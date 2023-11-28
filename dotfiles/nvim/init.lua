local v = vim
local o = v.opt
local g = v.g

-- globals that i always expect to be available
P = function(thing)
  print(v.print(thing))
  return thing
end

local get_mapper = function(mode)
  return function(lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    v.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end
local nmap = get_mapper("n")
local imap = get_mapper("i")
local vmap = get_mapper("v")

g.mapleader = " "
g.maplocalleader = " "

imap("kj", "<esc>")

nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")

nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")

nmap("<cr>", "<cmd>nohl<cr><cr>")

nmap("<leader>fe", "<cmd>Ex<cr><cr>")

vmap("<leader>y", '"+y')

o.timeoutlen = 500

o.number = true
o.relativenumber = true

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

o.ignorecase = true
o.smartcase = true

o.breakindent = true
o.showbreak = string.rep(" ", 3)
o.linebreak = true

o.formatoptions = o.formatoptions
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
v.cmd("au BufEnter * set fo-=o")

-- plugins
local lazypath = v.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not v.loop.fs_stat(lazypath) then
  v.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
o.rtp:prepend(lazypath)

require("lazy").setup {
  "nvim-lua/plenary.nvim",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "go", "lua", "typescript", "rust", "c", "zig" },
        highlight = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
        },
      }
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local servers = {
        gopls = {},
        lua_ls = {},
        tsserver = {},
        tailwindcss = {},
      }
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local handlers = {
        ["textDocument/hover"] = v.lsp.with(v.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = v.lsp.with(v.lsp.handlers.signature_help, { border = "rounded" }),
      }
      v.diagnostic.config {
        float = { border = "rounded" },
      }
      require("neodev").setup()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = v.tbl_keys(servers),
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              handlers = handlers,
              capabilities = capabilities,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          end,
        },
      }
      nmap("<leader>gd", "<cmd>lua vim.lsp.buf.definition{}<cr>")
      nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action{}<cr>")
      nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename{}<cr>")
      nmap("K", "<cmd>lua vim.lsp.buf.hover{}<cr>")
      nmap("<leader>sh", "<cmd>lua vim.lsp.buf.signature_help{}<cr>")
      nmap("<leader>se", "<cmd>lua vim.diagnostic.open_float{}<cr>")
      nmap("[d", "<cmd>lua vim.diagnostic.goto_prev{}<cr>")
      nmap("]d", "<cmd>lua vim.diagnostic.goto_next{}<cr>")
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item {
            behavior = cmp.SelectBehavior.Insert,
          },
          ["<C-p>"] = cmp.mapping.select_prev_item {
            behavior = cmp.SelectBehavior.Insert,
          },
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { "i", "c" }
          ),
          ["<tab>"] = cmp.config.disable,
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      }
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup {
        defaults = {
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
  },

  -- harpoon
  {
    "ThePrimeagen/harpoon",
    config = function()
      nmap("<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>")
      nmap("<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu{}<cr>")
      for i = 1, 5 do
        nmap(string.format("<leader>%s", i), string.format("<cmd>lua require 'harpoon.ui'.nav_file(%s)<cr>", i))
      end
      nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
    end,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "gofmt" },
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
        javascript = {
          __default = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          jsx_attribute = "// %s",
          comment = "// %s",
        },
        typescript = { __default = "// %s", __multiline = "/* %s */" },
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
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      }
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

  -- colorscheme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        keywordStyle = { italic = false },
        transparent = true,
        background = {
          dark = "dragon",
        },
      }
      v.cmd([[
        colorscheme kanagawa
        hi LineNr guibg=none
        hi SignColumn guibg=none
      ]])
    end,
  },

  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "github/copilot.vim",

  -- custom plugins
  -- { dir = "~/playground/stackmap.nvim" },
}

-- custom statusline
v.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged" }, {
  desc = "Git branch and LSP errors for the statusline",
  callback = function()
    if v.fn.isdirectory(".git") ~= 0 then
      local branch = v.fn.system("git branch --show-current | tr -d '\n'")
      v.b.branch_name = branch
    end

    local clients = v.lsp.get_active_clients { buffer = 0 }
    if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then
      v.b.lsp_status = "LSP: Off"
    else
      local num_errors = #v.diagnostic.get(0, { severity = v.diagnostic.severity.ERROR })
      local num_warnings = #v.diagnostic.get(0, { severity = v.diagnostic.severity.WARN })
      local num_infos = #v.diagnostic.get(0, { severity = v.diagnostic.severity.INFO })
      local num_hints = #v.diagnostic.get(0, { severity = v.diagnostic.severity.HINT })
      v.b.lsp_status = "LSP: "
        .. "E"
        .. num_errors
        .. ", "
        .. "W"
        .. num_warnings
        .. ", "
        .. "I"
        .. num_infos
        .. ", "
        .. "H"
        .. num_hints
    end
  end,
})
o.laststatus = 3
o.winbar = [[%=%m %f]]
o.statusline = [[%{get(b:,"lsp_status","")} %=%<%t [%{get(b:,"branch_name","")}] %h%m%r %=%-14.(%l,%c%V%) %P]]
