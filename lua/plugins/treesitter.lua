-- treesitter.lua
--
-- Syntax-aware highlighting and indentation. Parsers listed in
-- ensure_installed are compiled on first run (:TSUpdate); anything else is
-- installed automatically the first time that filetype is opened.
--
-- Not lazy-loaded on purpose: highlighting has to be ready before the first
-- buffer's FileType event, and the plugin costs only a few milliseconds.
--
-- BRANCH NOTE: this is the `master` branch, which upstream froze in 2025. The
-- rewritten `main` branch requires Neovim 0.12 (nightly as of Sep 2026), so
-- the migration is on hold until 0.12 is a stable release. When that happens:
-- set `branch = "main"`, install the `tree-sitter-cli` Mason package, and
-- replace the `configs.setup` call below with `require("nvim-treesitter").setup()`
-- plus a FileType autocommand that calls `vim.treesitter.start()` (see the
-- main-branch README). `master` keeps working on 0.11 in the meantime.

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"dockerfile",
				"go",
				"gomod",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
