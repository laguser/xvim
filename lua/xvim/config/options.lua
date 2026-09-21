-- ==============================================================================
-- ⚡ XVIM - Core Performance & Editor Options
-- ==============================================================================

local opt = vim.opt

-- 1. Performance & Provider Disabling (Sub-20ms Startup)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- 2. Line Numbers & Cursor
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"

-- 3. Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- 4. Search Behavior
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 5. Splits & Layout
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- 6. Performance & Responsiveness
opt.updatetime = 200
opt.timeoutlen = 300
opt.ttimeoutlen = 10

-- 7. Files, Buffers & Undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undolevels = 10000
opt.autoread = true
opt.confirm = true

-- 8. UI, Colors & Transparency
opt.termguicolors = true
opt.pumblend = 0
opt.pumheight = 10
opt.winblend = 0
opt.conceallevel = 2
opt.showmode = false -- Lualine already displays the mode
opt.showtabline = 2 -- Always show bufferline
opt.laststatus = 3  -- Global statusline across splits

-- 9. Clipboard & Mouse
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- 10. Smooth Scrolling
opt.smoothscroll = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 11. Completion & Formats
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Window Title
opt.title = true
opt.titlestring = "xvim - %t"
