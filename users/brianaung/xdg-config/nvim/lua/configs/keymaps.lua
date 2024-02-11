local nmap = require("utils.mapper").nmap
local vmap = require("utils.mapper").vmap

nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")

nmap("<cr>", "<cmd>nohl<cr><cr>")

vmap("<leader>y", '"+y')
nmap("<leader>p", '"+p')

nmap("<c-u>", "<c-u>zz")
nmap("<c-d>", "<c-d>zz")

vmap("J", ":m '>+1<cr>gv=gv")
vmap("K", ":m '<-2<cr>gv=gv")

nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
