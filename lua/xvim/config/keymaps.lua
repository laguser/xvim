-- ==============================================================================
-- ⚡ XVIM - Ergonomic Keymaps & Superpowers
-- ==============================================================================

local map = vim.keymap.set

-- 1. General & Escape
map({ "i", "x", "n", "s" }, "<Esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlights & escape" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File", silent = true })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit Window", silent = true })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All Force", silent = true })

-- 2. Smart Navigation Between Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- 3. Window Resizing
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- 4. Move Lines (Alt + j/k)
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- 5. Buffers (Tabs)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete Buffer (Force)" })

-- 6. Better Indenting (Keeps visual mode selection)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 7. Split Windows
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Window Horizontally" })

-- 8. Fast Explorer & Snacks Shortcuts
map("n", "<leader>e", function()
  if Snacks and Snacks.explorer then
    Snacks.explorer()
  else
    vim.cmd("Explore")
  end
end, { desc = "File Explorer" })

-- 9. Quick Center on jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
