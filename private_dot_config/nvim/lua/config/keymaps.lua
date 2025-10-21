vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode keymaps
vim.keymap.set("n", "<leader>vc", function() -- Open Neovim config in new tab
	vim.cmd("tabnew " .. vim.fn.stdpath("config"))
end, { desc = "Open Neovim config in new tab" })
map("n", "<leader>q", ":q<CR>", opts) -- Quit
map("n", "<leader>w", ":w<CR>", opts) -- Save

-- Window management
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
