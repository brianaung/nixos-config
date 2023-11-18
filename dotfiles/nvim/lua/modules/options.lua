-- Options
local o = vim.opt
local g = vim.g

-- g.loaded_matchparen = 1
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
o.cursorline = false
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

o.formatoptions = o.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- o.list = true
-- vim.cmd[[set listchars=tab:→\ ,eol:↲,extends:›,precedes:‹,nbsp:␣,trail:~]]
