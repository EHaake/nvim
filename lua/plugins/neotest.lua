-- neotest.lua
--
-- Run tests from inside the editor with per-test results in the gutter, a
-- summary tree, and output windows. Adapters:
--   Rust    rustaceanvim's built-in adapter (cargo test / cargo nextest)
--   Go      neotest-golang (go test; installs nothing extra)
--   Python  neotest-python (pytest if available, otherwise unittest)
--
-- Loaded on the first <leader>t keymap.
--
--   <leader>tt  run nearest test     <leader>ts  toggle summary tree
--   <leader>tf  run current file     <leader>to  show output of nearest test
--   <leader>ta  run whole project    <leader>tO  toggle output panel
--   <leader>td  debug nearest (dap)  <leader>tS  stop running tests

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"fredrikaverpil/neotest-golang",
	},
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run file",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "Run all tests",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop tests",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle output panel",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
				require("neotest-golang"),
				require("neotest-python"),
			},
		})
	end,
}
