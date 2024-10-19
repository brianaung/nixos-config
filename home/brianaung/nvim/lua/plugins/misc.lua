return {
  "tpope/vim-sleuth",
  "tpope/vim-surround",

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
        {
          name = "zettlekasten",
          path = "~/vaults/zettlekasten",
        },
        {
          name = "project",
          path = "~/vaults/project",
        },
      },
      daily_notes = {
        folder = "dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily-notes" },
        template = nil,
      },
    },
    keys = {
      { "<leader>on", "<Cmd>ObsidianNew<CR>" },
      { "<leader>od", "<Cmd>ObsidianDailies<CR>" },
      { "<leader>ow", "<Cmd>ObsidianWorkspace<CR>" },
      { "<leader>os", "<Cmd>ObsidianSearch<CR>" },
    },
  },

  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   opts = {},
  -- },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "-", "<Cmd>Yazi<CR>" },
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { "<Leader>db", "<cmd>DBUIToggle<CR>" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Close dbui buffer with the escape key",
        pattern = { "dbui" },
        group = vim.api.nvim_create_augroup("dbui_close_with_escape", { clear = true }),
        callback = function(event)
          vim.keymap.set("n", "<esc>", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
        end,
      })
    end,
  },

  {
    "mbbill/undotree",
    cmd = { "UndotreeShow", "UndotreeToggle" },
    keys = {
      { "<Leader>u", "<Cmd>UndotreeShow | UndotreeFocus<CR>" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Close undotree buffer with the escape key",
        pattern = { "undotree", "diff" },
        group = vim.api.nvim_create_augroup("undotree_close_with_escape", { clear = true }),
        callback = function(event)
          vim.keymap.set("n", "<esc>", "<Cmd>UndotreeHide<CR>", { buffer = event.buf, silent = true })
        end,
      })
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>" },
      { "<C-j>", "<Cmd>TmuxNavigateDown<CR>" },
      { "<C-k>", "<Cmd>TmuxNavigateUp<CR>" },
      { "<C-l>", "<Cmd>TmuxNavigateRight<CR>" },
    },
  },
}
