-- Always set your leader key before anything else.
vim.g.mapleader = vim.api.nvim_replace_termcodes("<Space>", true, true, true)

-- Setup Lazy.
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system { "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- See :h lazy.nvim-lazy.nvim-plugin-spec.
require("lazy").setup("plugin", { change_detection = { notify = false } })
