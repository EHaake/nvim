-- lazy-bootstrap.lua
--
-- Installs lazy.nvim (the plugin manager) into the Neovim data directory on
-- first run and adds it to the runtimepath. This is the standard snippet from
-- https://github.com/folke/lazy.nvim#-installation with no local changes.
--
-- The install directory is ~/.local/share/nvim/lazy/lazy.nvim on macOS/Linux.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)
