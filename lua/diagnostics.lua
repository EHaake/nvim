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
local base_virtual_text = {
  spacing = 2,
  prefix = "●",
  severity = {
    min = severity.WARN, -- only WARN and ERROR inline
  },
  format = function(diagnostic)
    -- 1) Per-source filter: hide inline text for disallowed sources
    if diagnostic.source and allowed_sources[diagnostic.source] == false then
      return nil -- no virtual text for this diagnostic
    end

    -- 2) First line only
    local msg = diagnostic.message:gsub("\n.*", "")

    -- 3) Truncate long messages
    local max = 80
    if #msg > max then
      msg = msg:sub(1, max - 3) .. "..."
    end

    return msg
  end,
}

function M.apply()
  vim.diagnostic.config({
    virtual_text = virtual_text_enabled and base_virtual_text or false,
    signs = signs_enabled,
    underline = true,        -- you can also make this a third toggle if you want
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
