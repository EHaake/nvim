-- Rust stuff here.
-- We're using rustaceanvim and crates
return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false,   -- plugin is already lazy internally
		ft = { "rust" },

		config = function()
			-- LSP config for rust-analyzer via rustaceanvim
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { silent = true, buffer = bufnr })

						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { silent = true, buffer = bufnr })
					end,
					default_settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
						},
					},
				},
				dap = {},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml" }, -- lazy load
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},
}
