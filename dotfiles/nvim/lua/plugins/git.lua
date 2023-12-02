local nmap = require("utils.mapper").nmap

return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      }
    end,
  },

  {
    "tpope/vim-fugitive",
    config = function()
      nmap("<leader>gs", "<cmd>G<cr>")
    end,
  },
}
