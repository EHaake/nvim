-- markdown-preview.lua
--
-- Live-preview Markdown in the browser. The `build` step installs the bundled
-- Node app the first time the plugin is installed (needs `node` on PATH).

return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Toggle markdown preview" },
	},
}
