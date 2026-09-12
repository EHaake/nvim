-- completions.lua
--
-- Autocompletion with blink.cmp (Rust fuzzy matcher, built-in LSP / path /
-- snippet / buffer sources) plus LuaSnip for snippet expansion and
-- friendly-snippets for a library of ready-made ones.
--
-- blink ships a prebuilt matcher binary for the pinned `version`; no build
-- step or Rust toolchain needed. If the download ever fails it falls back to
-- a Lua matcher and warns.
--
-- Keys while the menu is open (the "default" preset plus two overrides):
--   <C-n> / <C-p>  next / previous item      <C-y>   accept
--   <C-Space>      open menu / toggle docs    <C-e>   close menu
--   <C-l> / <C-h>  next / previous snippet placeholder
--   <C-b> / <C-f>  scroll documentation

return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				-- Optional native build for regex support in snippets. Skipped on
				-- Windows or when `make` isn't available.
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				-- Preselect the first item but don't insert it until accepted
				-- (same feel as the old completeopt=menu,menuone,noinsert).
				list = { selection = { preselect = true, auto_insert = false } },
				documentation = { auto_show = true, auto_show_delay_ms = 250 },
				-- Preview the selected item inline.
				ghost_text = { enabled = true },
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
					},
				},
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
			},
			-- Command-line completion is handled by wilder.nvim (lua/plugins/wilder.lua).
			cmdline = { enabled = false },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
