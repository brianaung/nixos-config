-- Configure LSP
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

local nvim_lsp = require "lspconfig"
local on_attach = function(client, bufnr)

  -- key mapping function
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>sh', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- Note: Following commands are moved to use Telescope picker
  -- nmap('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- nmap('<leader>gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  -- nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- nmap('<leader>gt', vim.lsp.buf.type_definition, 'Type [D]efinition')

  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
end

-- Enable following language servers
local servers = {
  tsserver = {},
  lua_ls = {},
  rust_analyzer = {
    diagnostics = {
      enable = true;
    },
  },
}

-- add additional completion capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
  function(server_name)
    nvim_lsp[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}
