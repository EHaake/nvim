-- diagnostics.lua
--
-- Owns everything about how `vim.diagnostic` presents LSP/linter results:
-- inline virtual text, gutter signs, underline, and the minimum severity shown.
-- It also exposes toggle/preset functions that the keymaps under <leader>ud
-- call at runtime (see lua/keymaps.lua).
--
-- The module keeps a small amount of state (which features are enabled, the
-- current severity floor, which sources may show inline text) and re-applies
-- the full `vim.diagnostic.config()` whenever any of it changes. `M.apply()` is
-- called once at the bottom of this file so the defaults take effect on
-- startup.
--
-- Defaults: virtual text ON, signs ON, WARN and above, all sources allowed.

local M = {}

local severity = vim.diagnostic.severity

-- [[ State ]]
local virtual_text_enabled = true
local signs_enabled = true
local min_severity = severity.WARN

-- Sources that are allowed to show INLINE virtual text. A source set to
-- `false` still produces diagnostics (floats, quickfix, signs); it just stays
-- out of the inline text. Used to quiet rustc when rust-analyzer is enough.
local allowed_sources = {
	["rust-analyzer"] = true,
	["rustc"] = true,
}

-- Virtual text options used whenever inline text is enabled.
local base_virtual_text = {
	spacing = 2,
	prefix = "●",
	severity = { min = min_severity },
	-- Keep inline messages to one line and at most 80 characters.
	format = function(diagnostic)
		if diagnostic.source and allowed_sources[diagnostic.source] == false then
			return nil
		end
		local msg = diagnostic.message:gsub("\n.*", "")
		local max = 80
		if #msg > max then
			msg = msg:sub(1, max - 3) .. "..."
		end
		return msg
	end,
}

-- [[ Apply ]]

--- Push the current state into `vim.diagnostic.config()`.
function M.apply()
	vim.diagnostic.config({
		virtual_text = virtual_text_enabled and base_virtual_text or false,
		signs = signs_enabled and { severity = { min = min_severity } } or false,
		underline = { severity = { min = min_severity } },
		update_in_insert = false,
		float = { source = true, border = "rounded" },
	})
end

-- [[ Severity ]]

local severity_cycle = {
	severity.ERROR, -- errors only
	severity.WARN, -- warn + error
	severity.HINT, -- everything (HINT/INFO/WARN/ERROR)
}

local severity_labels = {
	[severity.ERROR] = "ERROR only",
	[severity.WARN] = "WARN + ERROR",
	[severity.HINT] = "ALL severities",
}

local severity_cycle_index = 2 -- matches the WARN default above

--- Set the minimum severity shown inline, in the gutter, and underlined.
---@param level integer one of vim.diagnostic.severity.*
function M.set_min_severity(level)
	min_severity = level
	base_virtual_text.severity = { min = level }
	M.apply()
	vim.notify("Diagnostics severity: " .. (severity_labels[level] or tostring(level)), vim.log.levels.INFO)
end

function M.only_errors()
	M.set_min_severity(severity.ERROR)
end

function M.warn_and_error()
	M.set_min_severity(severity.WARN)
end

function M.all_severities()
	M.set_min_severity(severity.HINT)
end

--- Cycle ERROR -> WARN+ERROR -> ALL -> ERROR ...
function M.cycle_severity()
	severity_cycle_index = severity_cycle_index % #severity_cycle + 1
	M.set_min_severity(severity_cycle[severity_cycle_index])
end

-- [[ Feature toggles ]]

function M.toggle_virtual_text()
	virtual_text_enabled = not virtual_text_enabled
	M.apply()
end

function M.toggle_signs()
	signs_enabled = not signs_enabled
	M.apply()
end

--- Enable/disable diagnostics entirely (all buffers). Unlike the quiet preset
--- this also hides floats and empties the quickfix list.
function M.toggle()
	local enabled = not vim.diagnostic.is_enabled()
	vim.diagnostic.enable(enabled)
	vim.notify("Diagnostics " .. (enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

-- [[ Source filters (Rust) ]]

--- Inline text from rust-analyzer only; rustc/clippy output stays out of the buffer.
function M.only_rust_analyzer()
	allowed_sources["rust-analyzer"] = true
	allowed_sources["rustc"] = false
	M.apply()
end

--- Inline text from both rust-analyzer and rustc/clippy.
function M.allow_rustc()
	allowed_sources["rust-analyzer"] = true
	allowed_sources["rustc"] = true
	M.apply()
end

-- [[ Presets ]]

--- Quiet: no inline text, no signs. Diagnostics still exist for floats and lists.
function M.mode_quiet()
	virtual_text_enabled = false
	signs_enabled = false
	M.apply()
end

--- Full: inline text and signs on, every source allowed.
function M.mode_full()
	virtual_text_enabled = true
	signs_enabled = true
	allowed_sources["rust-analyzer"] = true
	allowed_sources["rustc"] = true
	M.apply()
end

-- Apply the defaults on startup.
M.apply()

return M
