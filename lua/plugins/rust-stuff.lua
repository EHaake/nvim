-- Rust stuff here.
-- We're using rustaceanvim and crates
return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false,
		ft = { "rust" },

		config = function()
			return {
				-- Plugin configuration
				tools = {},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						-- you can also put keymaps in here
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
							-- or vim.lsp.buf.codeAction() if you don't want grouping.
						end, { silent = true, buffer = bufnr })
					end,
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
				-- DAP configuration
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
