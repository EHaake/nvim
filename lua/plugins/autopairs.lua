-- autopairs.lua
--
-- Inserts the closing bracket/quote automatically. Also hooks into nvim-cmp
-- so that accepting a function completion adds the `(`.

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		require("nvim-autopairs").setup({})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
