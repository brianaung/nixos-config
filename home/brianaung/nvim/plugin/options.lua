-- See :h option-list.
local opt = vim.opt

opt.updatetime = 250
opt.timeoutlen = 300

opt.termguicolors = false

opt.scrolloff = 5

opt.foldenable = false

opt.conceallevel = 2

opt.number = true
opt.relativenumber = true
-- opt.cursorline = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.linebreak = true
opt.breakindent = true
opt.showbreak = "   "

opt.inccommand = "split"

opt.ignorecase = true
opt.smartcase = true

-- Better ins-completion experience
opt.completeopt = { "menuone", "noselect", "noinsert" }
opt.shortmess:append "c"

-- Display hidden characters.
opt.list = true
opt.listchars = {
  tab = "→ ",
  eol = "↲",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
  trail = "~",
}
