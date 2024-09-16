return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    servers = {
      lua_ls = {
        Lua = { diagnostics = { globals = { "vim" } } },
      },
      nil_ls = {},
      gopls = {},
      pyright = {},
      ts_ls = {},
      tailwindcss = {},
      phpactor = {},
      volar = {},
    },
    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      local set = vim.keymap.set
      set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
      set("n", "<Leader>gr", vim.lsp.buf.references, opts)
      set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
      set("n", "<Leader>gt", vim.lsp.buf.type_definition, opts)
      set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
      set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
      set("n", "K", vim.lsp.buf.hover, opts)
      set("n", "<Leader>sh", vim.lsp.buf.signature_help, opts)
      set("n", "<Leader>se", vim.diagnostic.open_float, opts)
      set("n", "[d", vim.diagnostic.goto_prev, opts)
      set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  },
  config = function(_, opts)
    for server, server_opts in pairs(opts.servers) do
      require("lspconfig")[server].setup {
        capabilities = opts.capabilities,
        on_attach = opts.on_attach,
        settings = server_opts,
        filetypes = (server_opts or {}).filetypes,
        init_options = (server_opts or {}).init_options,
      }
    end
  end,
}
