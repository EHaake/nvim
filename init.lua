-- init.lua
--
-- Entry point. Nothing is configured here directly; this file only decides the
-- order in which the modules under lua/ are loaded, then hands control to
-- lazy.nvim, which reads every file in lua/plugins/ as a plugin spec.
--
-- Load order matters:
--   1. lazy-bootstrap  clones lazy.nvim on first run and puts it on the runtimepath
--   2. settings        vim options, mapleader, and provider settings (must run
--                      before any plugin loads)
--   3. diagnostics     vim.diagnostic presentation and the toggle helpers
--   4. keymaps         global (non-plugin) keymaps
--   5. autocmds        autocommands and user commands
--   6. lazy.setup      installs/loads plugins from lua/plugins/*.lua
--
-- Plugin-specific keymaps live next to the plugin in lua/plugins/<name>.lua,
-- usually in a `keys = {}` table so the mapping also lazy-loads the plugin.
--
-- Handy commands while working on this config:
--   :Lazy            plugin manager UI (update, clean, profile)
--   :Lazy profile    per-plugin startup cost
--   :checkhealth     verify external tools and providers
--   :Mason           LSP servers, formatters, and debug adapters

require("lazy-bootstrap")
require("settings")
require("diagnostics")
require("keymaps")
require("autocmds")

require("lazy").setup({
	spec = { { import = "plugins" } },
	-- Colorscheme to use while plugins are being installed on a fresh clone.
	install = { colorscheme = { "nordic", "habamax" } },
	-- Don't nag on startup about available plugin updates; run :Lazy update by hand.
	checker = { enabled = false },
	-- Don't pop a notification every time a file in this repo is saved.
	change_detection = { notify = false },
	ui = { border = "rounded" },
	performance = {
		rtp = {
			-- Built-in Vim plugins that are never used in this setup.
			-- netrw is intentionally left enabled because neo-tree and oil hook into it.
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
})
