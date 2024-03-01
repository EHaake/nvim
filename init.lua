-- basic configuration stuff
vim.cmd("set expandtab") 
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- basic keymap stuff
vim.keymap.set('i', 'jk', '<Esc>') -- exit insert mode with 'jk'


-- get lazy.nvim loaded
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- List of plugins to install with lazy
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
     {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }

}

local opts = {}

require("lazy").setup(plugins, opts)

-- Telescope setup
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
