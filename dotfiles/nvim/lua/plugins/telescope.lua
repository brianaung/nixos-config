-- Configure Telescope
local telescope = require('telescope')
local actions = require("telescope.actions")
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    -- files to ignore when fuzzy finding
    file_ignore_patterns = { "node_modules" },
  },
}
-- load extensions
pcall(telescope.load_extension, 'fzf')
-- set keymaps
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map( "n", "<leader>fd", "<cmd>lua require 'telescope.builtin'.find_files{}<cr>", opts)
map( "n", "<leader>fe", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser{}<cr>", opts)
map( "n", "<leader>fb", "<cmd>lua require 'telescope.builtin'.buffers{}<cr>", opts)
map( "n", "<leader>/", "<cmd>lua require 'telescope.builtin'.current_buffer_fuzzy_find{}<cr>", opts)
map( "n", "<leader>lg", "<cmd>lua require 'telescope.builtin'.live_grep{}<cr>", opts)
map( "n", "<leader>gs", "<cmd>lua require 'telescope.builtin'.git_status{}<cr>", opts)
map( "n", "<leader>gc", "<cmd>lua require 'telescope.builtin'.git_commits{}<cr>", opts)
