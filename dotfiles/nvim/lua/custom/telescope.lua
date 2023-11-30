local nmap = require("mapper").nmap

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            preview_cutoff = 1,
          },
          vertical = {
            preview_cutoff = 1,
          },
        },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    }
    pcall(require("telescope").load_extension, "fzf")
    nmap("<leader>fd", "<cmd>lua require 'telescope.builtin'.find_files{}<cr>")
    nmap("<leader>lg", "<cmd>lua require 'telescope.builtin'.live_grep{}<cr>")
    nmap("<leader>fb", "<cmd>lua require 'telescope.builtin'.buffers{}<cr>")
  end,
}
