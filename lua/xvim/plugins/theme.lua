-- ==============================================================================
-- ⚡ XVIM - Monochrome Noir Aesthetic & Visual Engine
-- ==============================================================================

return {
  -- 1. Base Theme Configuration (Tokyonight configured as pure Monochrome Noir)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = true },
        keywords = { italic = false, bold = true },
      },
      on_highlights = function(hl, c)
        -- Pure Monochrome High-Contrast Overrides
        hl.Normal = { fg = "#ededed", bg = "NONE" }
        hl.NormalNC = { fg = "#aaaaaa", bg = "NONE" }
        hl.NormalFloat = { fg = "#ededed", bg = "NONE" }
        hl.FloatBorder = { fg = "#888888", bg = "NONE" }
        hl.FloatTitle = { fg = "#ffffff", bg = "NONE", bold = true }

        -- Line numbers & Cursor
        hl.LineNr = { fg = "#444444" }
        hl.CursorLineNr = { fg = "#ffffff", bold = true }
        hl.CursorLine = { bg = "#141417" }

        -- Splits & Separators
        hl.WinSeparator = { fg = "#333333" }
        hl.VertSplit = { fg = "#333333" }

        -- Popup Menu (Blink / Cmp)
        hl.Pmenu = { fg = "#d4d4d4", bg = "#111114" }
        hl.PmenuSel = { fg = "#000000", bg = "#ffffff", bold = true }
        hl.PmenuBorder = { fg = "#444444", bg = "NONE" }

        -- Statusline & Tabs
        hl.StatusLine = { fg = "#ededed", bg = "NONE" }
        hl.StatusLineNC = { fg = "#555555", bg = "NONE" }

        -- Search & Selection
        hl.Search = { fg = "#000000", bg = "#ffffff", bold = true }
        hl.IncSearch = { fg = "#000000", bg = "#ffffff", bold = true }
        hl.Visual = { bg = "#2a2a30" }

        -- Syntax: Sophisticated Grayscale
        hl.Comment = { fg = "#66666e", italic = true }
        hl.Keyword = { fg = "#ffffff", bold = true }
        hl.Function = { fg = "#f0f0f0", bold = true }
        hl.String = { fg = "#cccccc" }
        hl.Number = { fg = "#e0e0e0" }
        hl.Boolean = { fg = "#ffffff", bold = true }
        hl.Type = { fg = "#d8d8d8" }
        hl.Identifier = { fg = "#e8e8e8" }
        hl.Operator = { fg = "#aaaaaa" }

        -- Git Signs
        hl.GitSignsAdd = { fg = "#ffffff" }
        hl.GitSignsChange = { fg = "#888888" }
        hl.GitSignsDelete = { fg = "#444444" }

        -- Diagnostics
        hl.DiagnosticError = { fg = "#ffffff", bold = true }
        hl.DiagnosticWarn = { fg = "#cccccc" }
        hl.DiagnosticInfo = { fg = "#999999" }
        hl.DiagnosticHint = { fg = "#777777" }
      end,
    },
  },

  -- 2. Configure LazyVim to apply the theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
