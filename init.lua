-- init.lua
-- This is the starting point for all configuration in Neovim
--
--
-- load external modules
require("lazy-bootstrap") -- load lazy bootstrap

require("keymaps") -- load our keymaps file

require("settings") -- load our settings file

require("autocmds") -- load autocmds file

require("lazy").setup("plugins") -- loads everything in /plugins
