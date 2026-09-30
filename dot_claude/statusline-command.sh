#!/bin/bash
# Claude Code status line: the first line of the starship prompt, then model
# and usage. Nerd Font icons, ANSI colors that follow the terminal theme.
input=$(cat)
NOW=$(date +%s)

# ─── Colors (same names as starship) ──────────────────────────────
GREY=$'\033[90m'      # bright-black
PURPLE=$'\033[35m'
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
  read -r PR_NUM
  read -r PR_URL
} < <(echo "$input" | jq -r '
  (.model.display_name // ""),
  (.workspace.current_dir // .cwd // ""),
  (.context_window.used_percentage // ""),
  (.rate_limits.five_hour.used_percentage // ""),
  (.rate_limits.five_hour.resets_at // ""),
  (.rate_limits.seven_day.used_percentage // ""),
  (.cost.total_cost_usd // 0),
  (.effort.level // ""),
  (.pr.number // ""),
  (.pr.url // "")
')

# Green below 50%, yellow from 50%, red from 80%
pct_color() {
  if   (( $1 >= 80 )); then printf '%s' "$RED"
  elif (( $1 >= 50 )); then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

# ─── Starship prompt, first line (rendered for this directory) ────
OUT="" OUT2=""
if [[ -n "$DIR" ]] && command -v starship >/dev/null; then
  OUT=$(STARSHIP_SHELL= starship prompt --path "$DIR" --status 0 | grep -v '^$' | head -1)
fi

# ─── Open PR for the branch (clickable OSC 8) ─────────────────────
if [[ -n "$PR_NUM" ]]; then
  OUT+=" ${GREY}"$'\033]8;;'"${PR_URL}"$'\033\\'"#${PR_NUM}"$'\033]8;;\033\\'"${RST}"
fi

# ─── Model + effort (effort absent if the model lacks it) ─────────
[[ -n "$MODEL" ]] && OUT2+=" ${PURPLE}✦ ${MODEL}${RST}"
case "$EFFORT" in
  "")     ;;
  medium) OUT2+=" ${GREY}󰓅 med${RST}" ;;
  *)      OUT2+=" ${GREY}󰓅 ${EFFORT}${RST}" ;;
esac

# ─── Context (bar + percentage) ───────────────────────────────────
if [[ -n "$PCT_RAW" && "$PCT_RAW" != "null" ]]; then
  PCT=$(printf '%.0f' "$PCT_RAW")
  (( PCT < 0 )) && PCT=0; (( PCT > 100 )) && PCT=100
  F=$((PCT / 10)); BAR=""
  for ((i=0; i<F; i++)); do BAR+="█"; done
  for ((i=F; i<10; i++)); do BAR+="░"; done
  C=$(pct_color "$PCT")
  OUT2+=" ${GREY}󰍛${RST} ${C}${BAR}${RST} ${C}${PCT}%${RST}"
fi

# ─── Rate limits ──────────────────────────────────────────────────
if [[ -n "$FIVE_PCT" && "$FIVE_PCT" != "null" ]]; then
  FI=$(printf '%.0f' "$FIVE_PCT")
  OUT2+=" ${GREY}󰥔 5h${RST} $(pct_color "$FI")${FI}%${RST}"
  if [[ -n "$FIVE_RESET" && "$FIVE_RESET" != "null" ]]; then
    REM=$((${FIVE_RESET%%.*} - NOW))
    (( REM > 0 )) && OUT2+=" ${GREY}$((REM / 3600))h$(((REM % 3600) / 60))m${RST}"
  fi
fi
if [[ -n "$SEVEN_PCT" && "$SEVEN_PCT" != "null" ]]; then
  SI=$(printf '%.0f' "$SEVEN_PCT")
  OUT2+=" ${GREY}󰃭 7d${RST} $(pct_color "$SI")${SI}%${RST}"
fi

# ─── Cost ─────────────────────────────────────────────────────────
if [[ -n "$COST" && "$COST" != "null" && "$COST" != "0" ]]; then
  OUT2+=" ${GREY}$(printf '$%.2f' "$COST")${RST}"
fi

[[ -n "$OUT" ]] && printf '%s\n' "$OUT"
printf '%s\n' "${OUT2# }"
