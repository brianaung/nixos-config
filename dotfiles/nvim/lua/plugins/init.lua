-- package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Important!!! Contains neovim related lua functions that many plugins depends on
  'nvim-lua/plenary.nvim',

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
  },

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim', -- archived so might break in the near future
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-tree/nvim-web-devicons',
      -- Git Worktree (integrated with telescope)
      'ThePrimeagen/git-worktree.nvim',
    },
  },

  -- Others (below are more of a personal uses so feel free to customize)
  -- Commenter
  'numToStr/Comment.nvim',

  -- Colorschemes
  { 'rose-pine/neovim', name = 'rose-pine' },
  'olivercederborg/poimandres.nvim',
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- Statusline
  'nvim-lualine/lualine.nvim',

  -- Git
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  'github/copilot.vim',

  -- Note taking tool
  'renerocksai/telekasten.nvim',
}, {})
