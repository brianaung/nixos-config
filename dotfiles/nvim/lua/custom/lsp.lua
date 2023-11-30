local nmap = require("mapper").nmap

return {
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
      ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      ),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      ),
    }
    vim.diagnostic.config {
      float = { border = "rounded" },
    }
    require("neodev").setup {}
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = vim.tbl_keys(servers),
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
}
