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
vim.keymap.set("i", "<C-e>", "<end>", { desc = "Move cursor to end of line in insert mode" })
vim.keymap.set("i", "<C-a>", "<home>", { desc = "Move cursor to beginning of line in insert mode" })

-- Navigate beginning/end of line
vim.keymap.set("n", "H", "^", {})
vim.keymap.set("n", "L", "$", {})

-- Escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with 'jk'" })

-- save files
vim.keymap.set("n", "<leader>sf", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sa", "<cmd>wa<cr>", { desc = "Save all files " })

-- Buffers
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>", { desc = "go to previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>", { desc = "go to next buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>close<cr>", { desc = "close buffer" })

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight " })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", "<cmd>ToggleQFList<cr>", { desc = "Toggle diagnostic [q]uickfix list" })

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

-- Visual code movment
vim.keymap.set("v", "<", "< gv")
vim.keymap.set("v", ">", "> gv")

-- UI Stuff
--
-- Toggle 80 width column
vim.keymap.set("n", "<leader>uc", function()
	if vim.wo.colorcolumn == "" then
		vim.wo.colorcolumn = "80"
	else
		vim.wo.colorcolumn = ""
	end
end, { desc = "Toggle ui column (80 columnwidth)" })
