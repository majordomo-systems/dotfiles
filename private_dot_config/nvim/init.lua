-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lazy.nvim setup
require("lazy").setup({
  spec = {
    -- Load plugins from the plugins directory
    { import = "plugins" },
  },
  install = {
    -- Set default colorscheme during installation
    colorscheme = { "poimandres" },
  },
  -- Automatically check for plugin updates
  checker = { enabled = true },
})

-- General settings
vim.opt.termguicolors = true -- Enable true color support

-- Load custom mappings
require("mappings")

