return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			-- Document Prefixes
			require("which-key").add({
					{ "<leader>u", group = "[u]i" },
					{ "<leader>ud", group = "[d]iagnostics" },
					{ "<leader>udr", group = "[r]ust diagnostics" },
					{ "<leader>h", group = "[h]arpoon" },
					{ "", desc = "<leader>g_", hidden = true },
					{ "<leader>g", group = "[g]it" },
					{ "", desc = "<leader>f_", hidden = true },
					{ "", desc = "<leader>h_", hidden = true },
					{ "", desc = "<leader>m_", hidden = true },
					{ "<leader>m", group = "[m]arkdown" },
					{ "", desc = "<leader>r_", hidden = true },
					{ "<leader>r", group = "[r]ename" },
					{ "<leader>s", group = "[s]ave" },
					{ "<leader>f", group = "[f]ind" },
					{ "<leader>d", group = "[d]ebug" },
					{ "", desc = "<leader>w_", hidden = true },
					{ "<leader>w", group = "[w]orkspace" },
					{ "", desc = "<leader>u_", hidden = true },
					{ "", desc = "<leader>d_", hidden = true },
					{ "<leader>b", group = "[b]uffer" },
					{ "<leader>c", group = "[c]ode/[c]omment" },
					{ "", desc = "<leader>b_", hidden = true },
					{ "", desc = "<leader>c_", hidden = true },
					{ "", desc = "<leader>s_", hidden = true },
				})
			require("which-key").setup()
		end,
	},
}
