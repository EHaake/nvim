return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document Prefixes
			require("which-key").add({
					{ "", group = "[u]i" },
					{ "", group = "[h]arpoon" },
					{ "", desc = "<leader>g_", hidden = true },
					{ "", group = "[g]it" },
					{ "", desc = "<leader>f_", hidden = true },
					{ "", desc = "<leader>h_", hidden = true },
					{ "", desc = "<leader>m_", hidden = true },
					{ "", group = "[m]arkdown" },
					{ "", desc = "<leader>r_", hidden = true },
					{ "", group = "[r]ename" },
					{ "", group = "[s]ave" },
					{ "", group = "[f]ind" },
					{ "", group = "[d]ebug" },
					{ "", desc = "<leader>w_", hidden = true },
					{ "", group = "[w]orkspace" },
					{ "", desc = "<leader>u_", hidden = true },
					{ "", desc = "<leader>d_", hidden = true },
					{ "", group = "[b]uffer" },
					{ "", group = "[c]ode/[c]omment" },
					{ "", desc = "<leader>b_", hidden = true },
					{ "", desc = "<leader>c_", hidden = true },
					{ "", desc = "<leader>s_", hidden = true },
				})
		end,
	},
}
