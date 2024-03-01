vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.scrolloff = 8  -- always have at least 8 line between cursor and end of buffer
vim.g.mapleader = " "

-- basic keymap stuff
vim.keymap.set('i', 'jk', '<Esc>') -- exit insert mode with 'jk'


-- get lazy.nvim loaded
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath, }) end
vim.opt.rtp:prepend(lazypath)

--
-- Load our plugins
require("lazy").setup("plugins")
--

-- Telescope setup
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Treesitter setup
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "rust"},
  highlight = { enable = true },
  indent = { enable = true },
})

-- Neotree setup
vim.keymap.set('n', '<C-n>', ':Neotree toggle <CR>')

-- colorscheme
