local nmap = require("utils.mapper").nmap

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local servers = {
      gopls = {},
      lua_ls = {},
      ocamllsp = {},
      tsserver = {},
      tailwindcss = {},
    }

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      nmap("<leader>gd", "<cmd>lua vim.lsp.buf.definition{}<cr>", opts)
      nmap("<leader>gr", "<cmd>lua vim.lsp.buf.references{}<cr>", opts)
      nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action{}<cr>", opts)
      nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
      nmap("<leader>fmt", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
      nmap("K", "<cmd>lua vim.lsp.buf.hover{}<cr>", opts)
      nmap("<leader>sh", "<cmd>lua vim.lsp.buf.signature_help{}<cr>", opts)
      nmap("<leader>se", "<cmd>lua vim.diagnostic.open_float{}<cr>", opts)
      nmap("[d", "<cmd>lua vim.diagnostic.goto_prev{}<cr>", opts)
      nmap("]d", "<cmd>lua vim.diagnostic.goto_next{}<cr>", opts)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = vim.tbl_keys(servers),
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      },
    }
  end,
}
