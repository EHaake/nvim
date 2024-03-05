-- Treesitter
-- :vert help nvim-treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "javascript", "rust", "c", "cpp", "html", "markdown", "python" },
			-- Auto install languages that are not installed when opening a file of that type
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
