-- ==============================================================================
-- ⚡ XVIM - The Zero-Latency Monochrome Neovim Distribution
-- ==============================================================================

local M = {}

M.version = "1.0.0"

function M.setup()
  -- Load performance options first
  require("xvim.config.options")
  require("xvim.config.autocmds")
  require("xvim.config.keymaps")
  require("xvim.tutor").setup()
end

return M
