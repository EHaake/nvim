-- wilder.lua
--
-- Popup menu with fuzzy matching for the command line (:) and search (/ ?).
-- Adapted from https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/plugins/wilder.lua
--
-- Loaded the first time : / or ? is pressed. wilder is a Vimscript plugin and
-- checks `has('python3')` when the pipeline is built; that probe is what used
-- to make the first `:` of a session take a second. The Python provider is now
-- disabled in lua/settings.lua so the check returns instantly, and wilder
-- falls back to its built-in (Vim) fuzzy matcher, which is what we want anyway.
--
-- wilder.nvim hasn't been updated since 2022. If it ever breaks, Neovim's
-- built-in equivalent is `vim.opt.wildoptions = "pum,fuzzy"`.

return {
	{
		"gelguy/wilder.nvim",
		keys = { ":", "/", "?" },
		dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			local wilder = require("wilder")
			local macchiato = require("catppuccin.palettes").get_palette("macchiato")

			local text_hl = wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = macchiato.text } })
			local accent_hl = wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = macchiato.mauve } })

			wilder.setup({ modes = { ":", "/", "?" } })

			-- fuzzy = 1 uses Vim's matcher (no Python needed).
			wilder.set_option("pipeline", {
				wilder.branch(wilder.cmdline_pipeline({ fuzzy = 1 }), wilder.vim_search_pipeline({ fuzzy = 1 })),
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlighter = wilder.basic_highlighter(),
					highlights = { default = text_hl, border = accent_hl, accent = accent_hl },
					pumblend = 5,
					min_width = "100%",
					min_height = "25%",
					max_height = "25%",
					border = "rounded",
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				}))
			)
		end,
	},
}
