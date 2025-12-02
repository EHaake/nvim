-- lua/diagnostics.lua

local M = {}

local severity = vim.diagnostic.severity

-- Separate toggles
local virtual_text_enabled = true
local signs_enabled = true

-- Which sources are allowed to show INLINE text
local allowed_sources = {
  ["rust-analyzer"] = true,
  ["rustc"] = true,
}

-- Base config for virtual text when it's enabled
local min_severity = severity.WARN
local base_virtual_text = {
  spacing = 2,
  prefix = "●",
  severity = {
    min = min_severity,
  },
  format = function(diagnostic)
    -- your existing source filter + shortening logic
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

-- =========================
-- Severity controls
-- =========================

local severity_cycle = {
  severity.ERROR,  -- errors only
  severity.WARN,   -- warn + error
  severity.HINT,   -- all severities (HINT/INFO/WARN/ERROR)
}

local severity_labels = {
  [severity.ERROR] = "ERROR only",
  [severity.WARN]  = "WARN + ERROR",
  [severity.HINT]  = "ALL severities",
}

local severity_cycle_index = 2 -- default: WARN + ERROR

-- Set minimum severity directly
function M.set_min_severity(level)
  min_severity = level
  base_virtual_text.severity = { min = level }
  M.apply()

  local label = severity_labels[level] or tostring(level)
  vim.notify("Diagnostics severity: " .. label, vim.log.levels.INFO)
end

-- Convenience wrappers
function M.only_errors()
  M.set_min_severity(severity.ERROR)
end

function M.warn_and_error()
  M.set_min_severity(severity.WARN)
end

function M.all_severities()
  M.set_min_severity(severity.HINT)
end

-- Cycle between ERROR → WARN+ERROR → ALL
function M.cycle_severity()
  severity_cycle_index = severity_cycle_index % #severity_cycle + 1
  local level = severity_cycle[severity_cycle_index]
  M.set_min_severity(level)
end


function M.apply()
  local signs_cfg = signs_enabled and { severity = { min = min_severity } } or false

  local underline_cfg = {
    severity = {
      min = min_severity,
    },
  }

  vim.diagnostic.config({
    virtual_text = virtual_text_enabled and base_virtual_text or false,
    signs = signs_cfg,
    underline = underline_cfg,
    update_in_insert = false,
  })
end

-- Inline / virtual text toggles
function M.enable_virtual_text()
  virtual_text_enabled = true
  M.apply()
end

function M.disable_virtual_text()
  virtual_text_enabled = false
  M.apply()
end

function M.toggle_virtual_text()
  virtual_text_enabled = not virtual_text_enabled
  M.apply()
end

-- Gutter sign toggles
function M.enable_signs()
  signs_enabled = true
  M.apply()
end

function M.disable_signs()
  signs_enabled = false
  M.apply()
end

function M.toggle_signs()
  signs_enabled = not signs_enabled
  M.apply()
end

-- Source filters
function M.only_rust_analyzer()
  allowed_sources["rust-analyzer"] = true
  allowed_sources["rustc"] = false
  M.apply()
end

function M.allow_rustc()
  allowed_sources["rust-analyzer"] = true
  allowed_sources["rustc"] = true
  M.apply()
end

-- Preset modes
-- Quiet mode: no inline text, no signs (but diagnostics still exist for floats, etc.)
function M.mode_quiet()
  virtual_text_enabled = false
  signs_enabled = false
  M.apply()
end

-- Full compiler mode: rust-analyzer + rustc inline, signs on
function M.mode_full()
  virtual_text_enabled = true
  signs_enabled = true
  allowed_sources["rust-analyzer"] = true
  allowed_sources["rustc"] = true
  M.apply()
end

-- Initialize once on startup
M.apply()

return M
