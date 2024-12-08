local opt = vim.opt
local set = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.g.mapleader = vim.keycode "<space>"

vim.cmd "colorscheme theme"

-- {{{ Options
opt.updatetime = 250
opt.timeoutlen = 300

opt.termguicolors = false

opt.scrolloff = 5

opt.foldenable = false

opt.number = true
opt.relativenumber = true

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
-- }}}

-- {{{ Keymaps
set({ "n", "v" }, "<Leader>", "<nop>")

set("n", "j", "gj")
set("n", "k", "gk")

-- Re-center when scrolling.
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")

-- Yank and Paste from system clipboard.
set({ "n", "v" }, "<Leader>y", [["+y]])
set("n", "<Leader>Y", [["+Y]])
set("n", "<Leader>p", [["+p]])

-- Move selected lines.
set("v", "J", [[:m '>+1<CR>gv=gv]])
set("v", "K", [[:m '<-2<CR>gv=gv]])

-- Navigate through the quickfix list.
set("n", "<C-p>", "<Cmd>cprev<CR>")
set("n", "<C-n>", "<Cmd>cnext<CR>")

set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Use <CR> to clear hlsearch when active.
set("n", "<CR>", function() return vim.v.hlsearch == 1 and "<Cmd>nohl<CR>" or "<CR>" end, { expr = true })

-- Ins-completion keymaps
set("i", "<C-y>", function()
  if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
  if vim.fn.pumvisible() ~= 0 then return "<C-n><C-y>" end
  return "<C-y>"
end, { expr = true })

set("i", "<CR>", function()
  if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
  if vim.fn.pumvisible() ~= 0 then return "<C-e><CR>" end
  return "<CR>"
end, { expr = true })

set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active { direction = 1 } then return "<Cmd>lua vim.snippet.jump(1)<CR>" end
end, { expr = true })

set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active { direction = -1 } then return "<Cmd>lua vim.snippet.jump(-1)<CR>" end
end, { expr = true })
--- }}}

-- {{{ Autocmds
autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized.",
  group = augroup("resize_splits", {}),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text.",
  group = augroup("highlight_yank", {}),
  callback = function() vim.highlight.on_yank { higroup = "Visual" } end,
})

autocmd("BufEnter", {
  desc = "Set global format options.",
  group = augroup("set_formatoptions", {}),
  callback = function()
    -- -o: Don't add comment leader when I press 'o' or 'O'.
    vim.opt.formatoptions:remove { "o" }
  end,
})

autocmd("FileType", {
  desc = "Close certain windows with the escape key.",
  group = augroup("close_with_escape", {}),
  pattern = { "help", "qf", "man", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "<Esc>", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})
-- }}}

-- {{{ Plugins
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", { change_detection = { notify = false } })
-- }}}
