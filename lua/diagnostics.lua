-- lua/diagnostics.lua

local M = {}

local severity = vim.diagnostic.severity
local diagnostics_active = true

-- Which sources are allowed to show INLINE text
-- (signs/underlines still show regardless)
local allowed_sources = {
  ["rust-analyzer"] = true,
  ["rustc"] = true,
}

-- Base config used when diagnostics are "on"
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
    virtual_text = diagnostics_active and base_virtual_text or false,
    signs = diagnostics_active,
    underline = diagnostics_active,
    update_in_insert = false,
  })
end

function M.enable()
  diagnostics_active = true
  M.apply()
end

function M.disable()
  diagnostics_active = false
  M.apply()
end

function M.toggle()
  diagnostics_active = not diagnostics_active
  M.apply()
end

-- Only rust-analyzer inline text
function M.only_rust_analyzer()
  allowed_sources["rust-analyzer"] = true
  allowed_sources["rustc"] = false
  M.apply()
end

-- rust-analyzer + rustc inline text
function M.allow_rustc()
  allowed_sources["rust-analyzer"] = true
  allowed_sources["rustc"] = true
  M.apply()
end

-- initialize once on startup
M.enable()

return M
