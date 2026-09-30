#!/bin/bash
# Claude Code status line in the style of Starship's Pure preset:
# Nerd Font icons, no separators, ANSI colors that follow the terminal theme.
input=$(cat)
NOW=$(date +%s)

# ─── Colors (same names as the Pure preset) ───────────────────────
BLUE=$'\033[34m'
GREY=$'\033[90m'      # bright-black
PINK=$'\033[38;5;218m'
PURPLE=$'\033[35m'
CYAN=$'\033[36m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
RST=$'\033[0m'

# ─── Parse JSON (single jq call) ──────────────────────────────────
{
  read -r MODEL
  read -r DIR
  read -r PCT_RAW
  read -r FIVE_PCT
  read -r FIVE_RESET
  read -r SEVEN_PCT
  read -r COST
  read -r EFFORT
} < <(echo "$input" | jq -r '
  (.model.display_name // ""),
  (.workspace.current_dir // .cwd // ""),
  (.context_window.used_percentage // ""),
  (.rate_limits.five_hour.used_percentage // ""),
  (.rate_limits.five_hour.resets_at // ""),
  (.rate_limits.seven_day.used_percentage // ""),
  (.cost.total_cost_usd // 0),
  (.effort.level // "")
')

# Green below 50%, yellow from 50%, red from 80%
pct_color() {
  if   (( $1 >= 80 )); then printf '%s' "$RED"
  elif (( $1 >= 50 )); then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

OUT=""

# ─── Directory (clickable OSC 8) ──────────────────────────────────
if [[ -n "$DIR" ]]; then
  DNAME="${DIR##*/}"
  [[ "$DIR" == "$HOME" ]] && DNAME="~"
  OUT+="${BLUE}󰉋 "$'\033]8;;file://'"${DIR}"$'\033\\'"${DNAME}"$'\033]8;;\033\\'"${RST}"
fi

# ─── Git (matches Pure's git_branch + git_status; cached 5s) ─────
# "*" when anything is changed or untracked, then ⇡/⇣/⇕ vs upstream and ≡ for stashes
mtime() { stat -f %m "$1" 2>/dev/null || stat -c %Y "$1" 2>/dev/null; }
if [[ -n "$DIR" ]]; then
  CF="${TMPDIR:-/tmp}/claudeline-$(echo "$DIR" | cksum | cut -d' ' -f1)"
  BRANCH="" DIRTY="" EXTRA=""
  if [[ -f "$CF" ]] && (( NOW - $(mtime "$CF") < 5 )); then
    IFS='|' read -r BRANCH DIRTY EXTRA < "$CF"
  else
    g() { GIT_OPTIONAL_LOCKS=0 git -C "$DIR" "$@" 2>/dev/null; }
    if g rev-parse --git-dir >/dev/null; then
      BRANCH=$(g branch --show-current)
      [[ -z "$BRANCH" ]] && BRANCH=$(g rev-parse --short HEAD)
      [[ -n "$(g status --porcelain)" ]] && DIRTY="*"
      read -r BEHIND AHEAD < <(g rev-list --left-right --count '@{upstream}...HEAD')
      if   (( ${AHEAD:-0} > 0 && ${BEHIND:-0} > 0 )); then EXTRA="⇕"
      elif (( ${AHEAD:-0} > 0 )); then EXTRA="⇡"
      elif (( ${BEHIND:-0} > 0 )); then EXTRA="⇣"; fi
      g rev-parse --verify --quiet refs/stash >/dev/null && EXTRA+="≡"
    fi
    printf '%s|%s|%s' "$BRANCH" "$DIRTY" "$EXTRA" > "$CF"
  fi
  if [[ -n "$BRANCH" ]]; then
    OUT+=" ${GREY} ${BRANCH}${RST}${PINK}${DIRTY}${RST}"
    [[ -n "$EXTRA" ]] && OUT+=" ${CYAN}${EXTRA}${RST}"
  fi
fi

# ─── Model + effort (effort absent if the model lacks it) ─────────
[[ -n "$MODEL" ]] && OUT+=" ${PURPLE}✦ ${MODEL}${RST}"
case "$EFFORT" in
  "")     ;;
  medium) OUT+=" ${GREY}󰓅 med${RST}" ;;
  *)      OUT+=" ${GREY}󰓅 ${EFFORT}${RST}" ;;
esac

# ─── Context (bar + percentage) ───────────────────────────────────
if [[ -n "$PCT_RAW" && "$PCT_RAW" != "null" ]]; then
  PCT=$(printf '%.0f' "$PCT_RAW")
  (( PCT < 0 )) && PCT=0; (( PCT > 100 )) && PCT=100
  F=$((PCT / 10)); BAR=""
  for ((i=0; i<F; i++)); do BAR+="█"; done
  for ((i=F; i<10; i++)); do BAR+="░"; done
  C=$(pct_color "$PCT")
  OUT+=" ${GREY}󰍛${RST} ${C}${BAR}${RST} ${C}${PCT}%${RST}"
fi

# ─── Rate limits ──────────────────────────────────────────────────
if [[ -n "$FIVE_PCT" && "$FIVE_PCT" != "null" ]]; then
  FI=$(printf '%.0f' "$FIVE_PCT")
  OUT+=" ${GREY}󰥔 5h${RST} $(pct_color "$FI")${FI}%${RST}"
  if [[ -n "$FIVE_RESET" && "$FIVE_RESET" != "null" ]]; then
    REM=$((${FIVE_RESET%%.*} - NOW))
    (( REM > 0 )) && OUT+=" ${GREY}$((REM / 3600))h$(((REM % 3600) / 60))m${RST}"
  fi
fi
if [[ -n "$SEVEN_PCT" && "$SEVEN_PCT" != "null" ]]; then
  SI=$(printf '%.0f' "$SEVEN_PCT")
  OUT+=" ${GREY}󰃭 7d${RST} $(pct_color "$SI")${SI}%${RST}"
fi

# ─── Cost ─────────────────────────────────────────────────────────
if [[ -n "$COST" && "$COST" != "null" && "$COST" != "0" ]]; then
  OUT+=" ${GREY}$(printf '$%.2f' "$COST")${RST}"
fi

printf '%s\n' "${OUT# }"
