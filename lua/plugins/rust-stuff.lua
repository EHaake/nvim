-- rust-stuff.lua
--
-- Rust tooling:
--   rustaceanvim  starts and configures rust-analyzer itself (no nvim-lspconfig),
--                 adds :RustLsp commands, and wires up nvim-dap for Rust.
--   crates.nvim   version info, upgrades, and completion inside Cargo.toml.
--
-- rust-analyzer comes from the system (`rustup component add rust-analyzer`
-- or Homebrew), NOT from Mason; see the note in lua/plugins/lsp-config.lua.

return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false, -- the plugin lazy-loads itself on the rust filetype
		init = function()
			-- Must be set before the plugin loads, hence `init` rather than `config`.
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					on_attach = function(_, bufnr)
						-- Rust-flavoured replacements for the generic LSP keymaps.
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr, desc = "LSP: Code action (Rust)" })
						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { buffer = bufnr, desc = "LSP: Hover with actions (Rust)" })
					end,
					default_settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							-- Run clippy instead of `cargo check` on save. Set
							-- checkOnSave = false to turn off the rustc/clippy diagnostics
							-- entirely (or use <leader>udra to hide them inline only).
							checkOnSave = true,
							check = { command = "clippy" },
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
		event = { "BufRead Cargo.toml" },
		opts = {},
	},
}
