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

-- NOTE: This will load the config from the dir `lua/plugins/`.
-- Same as: `require("lazy").setup({{import = "plugins"}})`
require("lazy").setup("plugins")

-- load vim configs
require("configs.options")
require("configs.mappings")
require("configs.statusline")

-- load my custom snippets
require("snippets.lua")
require("snippets.go")
