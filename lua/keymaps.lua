-- keyamps.lua
--
-- This is where all global Neovim keymaps go, plugin specific keymaps will
-- go in their respective plugin files.
--
-- Map leader to Space
vim.g.mapleader = " "

-- Escape insert mode
vim.keymap.set('i', 'jk', '<Esc>') -- exit insert mode with 'jk'

-- save files
vim.keymap.set('n', '<leader>fs', "<cmd>w<cr>", {}) -- save current file
vim.keymap.set('n', '<leader>fw', "<cmd>wa<cr>", {}) -- save all files

-- Buffers
vim.keymap.set('n', '<leader>bp', "<cmd>bp<cr>", {}) -- previous buffer
vim.keymap.set('n', '<leader>bn', "<cmd>bn<cr>", {}) -- next buffer
