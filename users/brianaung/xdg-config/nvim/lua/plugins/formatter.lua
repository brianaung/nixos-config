local nmap = require("utils.mapper").nmap
return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				php = { "php_cs_fixer" },
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = true,
			-- 	-- timeout_ms = 500,
			-- },
		}
		nmap("<leader>fm", "<cmd>lua require('conform').format({ bufnr = 0 })<cr>")
	end,
}
