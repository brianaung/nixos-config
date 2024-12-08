return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt" },
      rust = { "rustfmt" },
      python = { "isort", "black" },
      javascript = { { "eslint_d", "prettierd", "prettier" } },
      typescript = { { "eslint_d", "prettierd", "prettier" } },
      typescriptreact = { { "eslint_d", "prettierd", "prettier" } },
      vue = { { "eslint_d", "prettierd", "prettier" } },
      -- php = { "php_cs_fixer" },
    },
    format_on_save = {
      lsp_fallback = false,
      timeout_ms = 500,
    },
  },
  keys = {
    {
      "<Leader>fmt",
      function() require("conform").format { bufnr = 0, lsp_fallback = true } end,
    },
  },
}
