-- ==============================================================================
-- ⚡ XVIM - The Zero-Latency Monochrome Neovim Distribution
-- ==============================================================================

-- 1. Enable native LuaJIT bytecode loader for sub-20ms startup
if vim.loader then
  vim.loader.enable()
end

-- 2. Initialize XVim Core (Options, Autocmds, Keymaps)
require("xvim").setup()

-- 3. Bootstrap lazy.nvim and load distribution plugins
require("config.lazy")
