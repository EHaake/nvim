-- todo-comments.lua
--
-- Highlights TODO:, FIXME:, NOTE:, HACK:, WARN: etc. in comments.
-- `:TodoTelescope` lists them across the project.

return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TodoTelescope", "TodoQuickFix" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}
