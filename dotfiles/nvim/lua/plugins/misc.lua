local nmap = require("utils.mapper").nmap

return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup {
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      }
    end,
  },

  {
    "mbbill/undotree",
    config = function()
      nmap("<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<cr>")
    end,
  },

  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = false -- i will call you when i need you
    end,
  },

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

  "tpope/vim-surround",

  -- custom plugins
  -- { dir = "~/playground/stackmap.nvim" },
}
