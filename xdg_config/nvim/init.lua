require("globals")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- You can just do `require("lazy").setup("plugins")`,
-- But I want to have the ability to comment out just one line to temporarily disable them.
require("lazy").setup {
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.harpoon" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.formatter" },
  { import = "plugins.colorscheme" },
  { import = "plugins.misc" },
}

-- load vim configs
require("configs.options")
require("configs.keymaps")
require("configs.statusline")

-- load my custom snippets
require("snippets.lua")
require("snippets.go")
