return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document Prefixes
			require("which-key").register({
				["<leader>c"] = { name = "[c]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[d]ebug", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[r]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[s]ave", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[w]orkspace", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[f]ind", _ = "which_key_ignore" },
				["<leader>b"] = { name = "[b]uffer", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[g]it", _ = "which_key_ignore" },
			})
		end,
	},
}
