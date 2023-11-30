local o = vim.opt

o.timeoutlen = 500

o.number = true
o.relativenumber = true

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

o.ignorecase = true
o.smartcase = true

o.breakindent = true
o.showbreak = "   "
o.linebreak = true

o.formatoptions = o.formatoptions
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.

vim.cmd("au BufEnter * set fo-=o")
