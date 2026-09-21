-- ==============================================================================
-- ⚡ XVIM - UI & Dashboard Experience
-- ==============================================================================

local banner = require("xvim.banner")
local lang = require("xvim.config.lang")

return {
  -- 1. Snacks Suite (Dashboard, Scroll, Indent, Notifier)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 2500,
        style = "compact",
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      indent = {
        enabled = true,
        char = "│",
        only_scope = false,
        hl = "LineNr",
      },
      dashboard = {
        enabled = true,
        preset = {
          header = banner.logo,
          keys = {
            { icon = " ", key = "f", desc = lang.get("files"), action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = lang.get("grep"), action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = lang.get("recent"), action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "󰑴 ", key = "t", desc = lang.get("tutor"), action = ":XVimTutor" },
            { icon = "󰒓 ", key = "c", desc = lang.get("config"), action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󰈆 ", key = "q", desc = lang.get("quit"), action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          {
            text = {
              { "  " .. banner.title, hl = "Bold" },
            },
            align = "center",
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = lang.get("recent_title"),
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          {
            pane = 2,
            icon = " ",
            title = lang.get("projects_title"),
            section = "projects",
            indent = 2,
            padding = 1,
          },
          { section = "startup" },
        },
      },
    },
    init = function()
      local d = require("snacks.dashboard")
      d.sections.startup = function()
        local stats = require("lazy.stats").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return {
          align = "center",
          text = {
            { "xvim  ", hl = "Bold" },
            { tostring(ms) .. "ms", hl = "Comment" },
          },
        }
      end
    end,
  },

  -- 2. Lualine (Monochrome Statusline)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local mono_theme = {
        normal = {
          a = { fg = "#000000", bg = "#ffffff", gui = "bold" },
          b = { fg = "#ffffff", bg = "#222226" },
          c = { fg = "#888888", bg = "NONE" },
        },
        insert = {
          a = { fg = "#000000", bg = "#cccccc", gui = "bold" },
          b = { fg = "#ffffff", bg = "#222226" },
          c = { fg = "#888888", bg = "NONE" },
        },
        visual = {
          a = { fg = "#ffffff", bg = "#44444c", gui = "bold" },
          b = { fg = "#ffffff", bg = "#222226" },
          c = { fg = "#888888", bg = "NONE" },
        },
        replace = {
          a = { fg = "#000000", bg = "#ffffff", gui = "bold" },
          b = { fg = "#ffffff", bg = "#222226" },
          c = { fg = "#888888", bg = "NONE" },
        },
        command = {
          a = { fg = "#000000", bg = "#e0e0e0", gui = "bold" },
          b = { fg = "#ffffff", bg = "#222226" },
          c = { fg = "#888888", bg = "NONE" },
        },
        inactive = {
          a = { fg = "#555555", bg = "NONE" },
          b = { fg = "#555555", bg = "NONE" },
          c = { fg = "#444444", bg = "NONE" },
        },
      }

      return {
        options = {
          theme = mono_theme,
          globalstatus = true,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str) return str:upper() end,
              separator = { left = "", right = "" },
              padding = { left = 0, right = 0 },
            },
          },
          lualine_b = { { "branch", icon = "󰘬" }, "diff" },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
          },
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                local names = {}
                for _, c in ipairs(clients) do
                  table.insert(names, c.name)
                end
                return "󰒋 " .. table.concat(names, ", ")
              end,
              color = { fg = "#888888" },
            },
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          },
          lualine_y = {
            {
              function()
                return string.format("󰍛 %.1fMB", collectgarbage("count") / 1024)
              end,
              color = { fg = "#666666" },
            },
            "fileformat",
          },
          lualine_z = {
            {
              "location",
              separator = { left = "", right = "" },
              padding = { left = 0, right = 0 },
            },
          },
        },
      }
    end,
  },

  -- 3. Bufferline (Monochrome Tabs)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
        indicator = {
          style = "underline",
        },
      },
    },
  },
}
