-- debugging.lua
--
-- Debug Adapter Protocol support (nvim-dap) with the nvim-dap-ui front end.
-- Adapters are installed by mason-nvim-dap (delve for Go). Rust debugging is
-- wired up by rustaceanvim (lua/plugins/rust-stuff.lua), which configures
-- nvim-dap with codelldb/lldb on its own.
--
-- Nothing here loads until a debug keymap is pressed or a :Dap* command runs.
--
--   <F5>         start / continue        <F1>  step into
--   <F2>         step over               <F3>  step out
--   <F7>         toggle the DAP UI       <leader>db  toggle breakpoint
--   <leader>dB   conditional breakpoint

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- required by nvim-dap-ui
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	cmd = { "DapContinue", "DapToggleBreakpoint", "DapNew" },
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step out",
		},
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Conditional breakpoint",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			handlers = {},
			ensure_installed = {
				"delve", -- Go
			},
		})

		dapui.setup({
			-- Plain characters so the UI works in any terminal font.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Open the UI when a session starts and close it when the session ends.
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		require("dap-go").setup()
	end,
}
