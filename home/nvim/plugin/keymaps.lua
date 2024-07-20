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
  if vim.snippet.active { direction = 1 } then return "<cmd>lua vim.snippet.jump(1)<cr>" end
end, { expr = true })

set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active { direction = -1 } then return "<cmd>lua vim.snippet.jump(-1)<cr>" end
end, { expr = true })
