local nmap = require("utils.mapper").nmap

return {
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup()
      nmap("<leader>fe", "<cmd>lua MiniFiles.open()<cr>")
    end,
  },

  {
    "tpope/vim-fugitive",
    config = function()
      nmap("<leader>gs", "<cmd>G<cr>")
    end,
  },

  "tpope/vim-surround",

  {
    "mbbill/undotree",
    config = function()
      nmap("<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<cr>")
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
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup {
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        },
      }
    end,
  },

  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.g.copilot_enabled = false -- i will call you when i need you
  --   end,
  -- },

  -- custom plugins
  -- { dir = "~/projects/ugly.nvim" },
}
