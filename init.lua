-- init.lua
--
--
-- get lazy.nvim loaded
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- load external modules
require("keymaps") -- load our keymaps file
require("vim-settings") -- load our settings file
require("lazy").setup("plugins") -- loads everything in /plugins
