local v = vim

-- Vim Mappings --
local get_mapper = function(mode, noremap)
  return function(lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = noremap
    v.keymap.set(mode, lhs, rhs, opts)
  end
end

-- local noremap = get_mapper("n", false)
local nnoremap = get_mapper("n", true)
local inoremap = get_mapper("i", true)
-- local tnoremap = get_mapper("t", true)
-- local vnoremap = get_mapper("v", true)

inoremap("kj", "<esc>")

-- better movement between lines
nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("gj", "j")
nnoremap("gk", "k")

-- remove search highlight
nnoremap("<cr>", "<cmd>nohl<cr><cr>")
-- ////////////////////////////////////


-- Plugin Specific Mappings --
local map = v.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Harpoon
map("n", "<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>", opts)
map("n", "<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu{}<cr>", opts)
-- map("n", "<C-h>", "<cmd>lua require 'harpoon.ui'.nav_file(1)<cr>", opts)
-- map("n", "<C-t>", "<cmd>lua require 'harpoon.ui'.nav_file(2)<cr>", opts)
-- map("n", "<C-n>", "<cmd>lua require 'harpoon.ui'.nav_file(3)<cr>", opts)
-- map("n", "<C-s>", "<cmd>lua require 'harpoon.ui'.nav_file(4)<cr>", opts)

-- Telekasten
map("n", "<leader>z", "<cmd>Telekasten panel<cr>", opts)
map("n", "<leader>zz", "<cmd>Telekasten follow_link<cr>", opts)
map("i", "[[", "<cmd>Telekasten insert_link<cr>", opts)

-- Telescope
-- File Pickers
map("n", "<leader>fd", "<cmd>lua require 'telescope.builtin'.find_files{}<cr>", opts)
map("n", "<leader>lg", "<cmd>lua require 'telescope.builtin'.live_grep{}<cr>", opts)
map("n", "<leader>fe", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser{}<cr>", opts)

-- Vim Pickers
map("n", "<leader>fb", "<cmd>lua require 'telescope.builtin'.buffers{}<cr>", opts)
-- map("n", "<leader>/", "<cmd>lua require 'telescope.builtin'.current_buffer_fuzzy_find{}<cr>", opts)

-- Git Pickers
map("n", "<leader>gs", "<cmd>lua require 'telescope.builtin'.git_status{}<cr>", opts)
map("n", "<leader>gc", "<cmd>lua require 'telescope.builtin'.git_commits{}<cr>", opts)
map("n", "<leader>gb", "<cmd>lua require 'telescope.builtin'.git_branches{}<cr>", opts)

-- Git Worktree
-- map("n", "<leader>fw", "<cmd>lua require 'telescope'.extensions.git_worktree.git_worktrees{}<cr>", opts)
-- map("n", "<leader>cw", "<cmd>lua require 'telescope'.extensions.git_worktree.create_git_worktree{}<cr>", opts)

-- LSP
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev{}<cr>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next{}<cr>", opts)
map("n", "<leader>se", "<cmd>lua vim.diagnostic.open_float{}<cr>", opts)
map("n", '<leader>rn', "<cmd>lua vim.lsp.buf.rename{}<cr>", opts)
map("n", '<leader>ca', "<cmd>lua vim.lsp.buf.code_action{}<cr>", opts)
map("n", 'K', "<cmd>lua vim.lsp.buf.hover{}<cr>", opts)
map("n", '<leader>sh', "<cmd>lua vim.lsp.buf.signature_help{}<cr>", opts)

-- Telescope LSP Pickers
map("n", "<leader>gd", "<cmd>lua require 'telescope.builtin'.lsp_definitions{}<cr>", opts)
map("n", "<leader>gi", "<cmd>lua require 'telescope.builtin'.lsp_implementations{}<cr>", opts)
map("n", "<leader>gr", "<cmd>lua require 'telescope.builtin'.lsp_references{}<cr>", opts)
map("n", "<leader>gt", "<cmd>lua require 'telescope.builtin'.lsp_type_definitions{}<cr>", opts)
map("n", "<leader>d", "<cmd>lua require 'telescope.builtin'.diagnostics{ bufnr=0}<cr>", opts)
-- ////////////////////////////////////
