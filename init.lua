
--
-- load external modules
require("lazy-bootstrap") -- load lazy bootstrap
require("settings") -- load our settings file
require("keymaps") -- load our keymaps file
require("diagnostics") -- load diagnostics file
require("autocmds") -- load autocmds file
require("lazy").setup("plugins") -- loads everything in /plugins
