local set = vim.keymap.set

set({ "n", "v" }, "<leader>", "<nop>")

set("n", "j", "gj")
set("n", "k", "gk")

-- Re-center when scrolling.
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")

-- Yank and Paste from system clipboard.
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])
set("n", "<leader>p", [["+p]])

-- Move selected lines.
set("v", "J", [[:m '>+1<CR>gv=gv]])
set("v", "K", [[:m '<-2<CR>gv=gv]])

-- Navigate through the quickfix list.
set("n", "<C-p>", "<Cmd>cprev<CR>")
set("n", "<C-n>", "<Cmd>cnext<CR>")

set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Use <CR> to clear hlsearch when active.
set("n", "<CR>", function() return vim.v.hlsearch == 1 and "<Cmd>nohl<CR>" or "<CR>" end, { expr = true })
