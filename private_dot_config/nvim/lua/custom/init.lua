-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- NvimTree configuration: open on the right side
require("nvim-tree").setup {
  view = {
    side = "right",     -- Set NvimTree to open on the right side
    signcolumn = "no",  -- Optional: Hides the sign column
  },
}


