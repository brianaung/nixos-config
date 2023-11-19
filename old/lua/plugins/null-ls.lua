local null_ls = require("null-ls")

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        -- bufnr = bufnr,
        async = false,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

require("null-ls").setup({
    -- you can reuse a shared lspconfig on_attach callback here
    sources = {
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.gofmt,
      -- null_ls.builtins.formatting.goimports,
      -- null_ls.builtins.formatting.goimports_reviser,
    },
    on_attach = on_attach
})
