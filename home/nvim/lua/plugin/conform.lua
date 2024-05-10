return {
	'stevearc/conform.nvim',
	opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			go = { 'gofmt' },
			rust = { 'rustfmt' },
			python = { 'isort', 'black' },
			javascript = { { 'prettierd', 'prettier' } },
			typescript = { { 'prettierd', 'prettier' } },
			typescriptreact = { { 'prettierd', 'prettier' } },
			vue = { { 'prettierd', 'prettier' } },
			php = { 'php_cs_fixer' },
		},
	},
	keys = {
		{
			'<leader>fmt',
			function() require('conform').format { bufnr = 0, lsp_fallback = true } end,
		},
	},
}
