-- ==============================================================================
-- ⚡ XVIM - LSP, Diagnostics & Formatting Engine
-- ==============================================================================

return {
  -- 1. LSP Configuration with fast modern handlers
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false, -- toggle with <leader>uh for clean view
      },
    },
  },

  -- 2. Conform.nvim - Ultra fast formatter
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
        bash = { "shfmt" },
        sh = { "shfmt" },
      },
    },
  },
}
