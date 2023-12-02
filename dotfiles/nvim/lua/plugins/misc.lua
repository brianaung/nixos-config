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

  "tpope/vim-surround",

  -- custom plugins
  -- { dir = "~/playground/stackmap.nvim" },
}
