-- vim-settings.lua
-- This file contains all the basic global vim settings I want
--
-- Neovide settings
if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono:h13"
	-- vim.o.guifont = "Anonymous Pro:h14"
	vim.g.neovide_scale_factor = 1.4
end

-- tabs and spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Scrolling
vim.opt.scrolloff = 8 -- always have at least 8 line between cursor and end of buffer
-- Add line numbers
vim.opt.number = true

-- signcolumn always open so errors/warnings don't push buffer
vim.o.signcolumn = "yes:1"
--
-- Set highlight on search
vim.opt.hlsearch = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Ignore casing in search + smartcase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Turn on 24 bit colors
vim.opt.termguicolors = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--vim.opt.list = true
--vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.diagnostic.config({
	float = {
		source = "always",
	},
})
