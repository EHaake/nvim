-- completions.lua
--
-- Autocompletion with nvim-cmp plus LuaSnip for snippets. Adapted from
-- kickstart.nvim. Loaded on the first InsertEnter; nvim-lspconfig also pulls
-- in cmp-nvim-lsp for its capabilities, which loads cmp when a file is opened.
--
-- Keys while the menu is open (see `:help ins-completion` for the reasoning):
--   <C-n> / <C-p>  next / previous item
--   <C-y>          accept the selected item
--   <C-Space>      open the menu manually
--   <C-l> / <C-h>  jump forward / back through snippet placeholders

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				-- Optional native build for regex support in snippets. Skipped on
				-- Windows or when `make` isn't available.
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			-- Completion sources. nvim-cmp keeps these in separate repos.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- Icons in the completion menu.
			"onsails/lspkind.nvim",
			-- Auto-close/rename HTML/JSX tags.
			"windwp/nvim-ts-autotag",
			-- A large collection of ready-made snippets (loaded lazily below).
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path", max_item_count = 3 },
					-- { name = "buffer", max_item_count = 5 },
				},
				formatting = {
					expandable_indicator = true,
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
				experimental = {
					-- Preview the selected completion inline as ghost text.
					ghost_text = true,
				},
			})
		end,
	},
}
