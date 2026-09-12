-- comment.lua
--
-- Toggle comments: `gcc` for a line, `gc` + motion, `gb` for block comments.
-- Neovim 0.10+ has `gc` built in; Comment.nvim adds block comments (`gb`) and
-- better handling of embedded languages. See `:help comment.config`.

return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	opts = {},
}
