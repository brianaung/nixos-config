local nmap = require("utils.mapper").nmap

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup {
      defaults = {
        mappings = {
          i = { ["<esc>"] = actions.close },
        },
      },
    }
    pcall(require("telescope").load_extension, "fzf")
    nmap("<leader>fd", "<cmd>lua require 'telescope.builtin'.find_files()<cr>")
    nmap("<leader>lg", "<cmd>lua require 'telescope.builtin'.live_grep()<cr>")
    nmap("<leader>fb", "<cmd>lua require 'telescope.builtin'.buffers()<cr>")
  end,
}
