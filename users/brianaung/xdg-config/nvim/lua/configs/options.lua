local o = vim.opt

o.timeoutlen = 500

o.number = true
o.relativenumber = true

-- o.cursorline = true

o.tabstop = 4
o.shiftwidth = 4
-- o.softtabstop = 4
o.expandtab = false

o.ignorecase = true
o.smartcase = true

o.breakindent = true
o.showbreak = "   "
o.linebreak = true

o.termguicolors = true

o.completeopt = { "menuone", "noselect" }

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
vim.cmd("au BufEnter * set fo-=o")

o.list = true
vim.cmd([[set listchars=tab:→\ ,eol:↲,extends:›,precedes:‹,nbsp:␣,trail:~]])
