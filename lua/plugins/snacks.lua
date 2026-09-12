-- snacks.lua
--
-- folke/snacks.nvim is a bundle of small QoL modules; every module is off
-- unless enabled here. Enabled modules and what they replaced:
--   dashboard   start screen (was alpha-nvim)         <leader>a  reopen
--   terminal    floating terminal (was FTerm)          <F9>       toggle
--   words       highlight LSP references of the word under the cursor
--               (was vim-illuminate)                   <leader>] / <leader>[ jump
--   input       floating vim.ui.input (was dressing.nvim)
--   bufdelete   close a buffer without collapsing the window layout
--                                                      <leader>bd / <leader>bD
--   indent      indent guides
--   bigfile     turns off treesitter/LSP/etc. in very large files
--
-- vim.ui.select is still handled by telescope-ui-select (lua/plugins/telescope.lua).
-- Everything else in snacks (picker, notifier, scroll, ...) stays off.

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>a",
			function()
				Snacks.dashboard()
			end,
			desc = "Open dashboard",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete buffer",
		},
		{
			"<leader>bD",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Delete other buffers",
		},
		{
			"<F9>",
			function()
				Snacks.terminal.toggle()
			end,
			mode = { "n", "t" },
			desc = "Toggle floating terminal",
		},
		{
			"<leader>]",
			function()
				Snacks.words.jump(1, true)
			end,
			desc = "Next reference",
		},
		{
			"<leader>[",
			function()
				Snacks.words.jump(-1, true)
			end,
			desc = "Previous reference",
		},
	},
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		input = { enabled = true },
		indent = { enabled = true, animate = { enabled = false } },
		words = { enabled = true },
		terminal = {
			win = { style = "float", border = "double", width = 0.7, height = 0.8 },
		},
		dashboard = {
			enabled = true,
			preset = {
				header = table.concat({
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				}, "\n"),
				keys = {
					{ icon = " ", key = "f", desc = "Find file", action = ":Telescope find_files" },
					{ icon = " ", key = "e", desc = "New file", action = ":ene | startinsert" },
					{ icon = " ", key = "r", desc = "Recent files", action = ":Telescope oldfiles" },
					{ icon = " ", key = "t", desc = "Find text", action = ":Telescope live_grep" },
					{ icon = " ", key = "s", desc = "Restore session", section = "session" },
					{ icon = " ", key = "c", desc = "Configuration", action = ":e ~/.config/nvim/init.lua" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
	},
}
