-- keymaps.lua
--
-- This is where all global Neovim keymaps go, plugin specific keymaps will
-- go in their respective plugin files.
--
-- Map leader to Space
vim.g.mapleader = " "

-- Enable emacs cursor commands in insert mode
vim.keymap.set("i", "<C-f>", "<right>", { desc = "Move cursor right in insert mode" })
vim.keymap.set("i", "<C-b>", "<left>", { desc = "Move cursor left in insert mode" })
vim.keymap.set("i", "<C-n>", "<down>", { desc = "Move cursor down in insert mode" })
vim.keymap.set("i", "<C-p>", "<up>", { desc = "Move cursor up in insert mode" })

-- Escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with 'jk'" })

-- save files
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>fw", "<cmd>wa<cr>", { desc = "Save all files " })

-- Buffers
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Go [B]uffer [P]revious" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Go [B]uffer [N]ext" })

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight " })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window Navigation
-- Use CTRL+<hjkl> to switch between windows
--
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
