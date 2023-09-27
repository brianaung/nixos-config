-- Options
local o = vim.opt
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.number = true
o.relativenumber = true
o.hlsearch = true
o.signcolumn = 'yes'
o.breakindent = true
o.showbreak = string.rep(" ", 3)
o.linebreak = true
o.termguicolors = true
o.scrolloff = 5
o.cursorline = true
-- indentation
o.autoindent = true
o.cindent = true
o.wrap = true
-- sync clipboard between OS and nvim
o.clipboard = 'unnamedplus'
-- decrease update time
o.updatetime = 250
o.timeoutlen = 300
-- case insensitive search
o.ignorecase = true
o.smartcase = true
-- better completion experience
o.completeopt = 'menuone,noselect'
