return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	cmd = {
		"MarkdownPreviewToggle",
		"MarkdownPreview",
		"MarkdownPreviewStop",
	},

	config = function()
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr> ", { desc = "Markdown preview toggle" })
	end,
}
