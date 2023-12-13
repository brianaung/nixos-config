local nmap = require("utils.mapper").nmap

return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt" },
        ocaml = { "ocamlformat" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
    }
    nmap(
      "<leader>ff",
      "<cmd>lua require('conform').format { async = true, lsp_fallback = true }<cr>"
    )
  end,
}
