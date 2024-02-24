return {
	'mfussenegger/nvim-lint',
	event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
	opts = {
		linters_by_ft = {
			lua = { 'selene' },
		},
	},
	config = function(_, opts)
		local lint = require('lint')
		lint.linters_by_ft = opts.linters_by_ft
		-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
		-- 	callback = function() lint.try_lint() end,
		-- })
	end,
}
