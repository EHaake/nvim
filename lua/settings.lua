-- vim-settings.lua
-- This file contains all the basic global vim settings I want

-- tabs and spaces
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Scrolling
vim.opt.scrolloff = 8 -- always have at least 8 line between cursor and end of buffer

-- Add line numbers
vim.wo.number = true

-- signcolumn always open so errors/warnings don't push buffer
vim.o.signcolumn = "yes:1"
--
-- Set highlight on search
vim.opt.hlsearch = true
