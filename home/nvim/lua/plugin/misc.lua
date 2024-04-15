return {
	'tpope/vim-sleuth',
	'tpope/vim-surround',
	'mbbill/undotree',

	{
		'brianaung/yasl.nvim',
		opts = {},
	},

	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
				go = { 'gofmt' },
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
	},

	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
		opts = {},
		cmd = { 'Gitsigns' },
	},

	{
		'ThePrimeagen/harpoon',
		keys = {
			{ '<leader>a', function() require('harpoon.mark').add_file() end },
			{ '<leader>h', function() require('harpoon.ui').toggle_quick_menu() end },
			{ '<leader>1', function() require('harpoon.ui').nav_file(1) end },
			{ '<leader>2', function() require('harpoon.ui').nav_file(2) end },
			{ '<leader>3', function() require('harpoon.ui').nav_file(3) end },
			{ '<leader>4', function() require('harpoon.ui').nav_file(4) end },
		},
	},

	-- Tmux-Vim navigation
	{
		'christoomey/vim-tmux-navigator',
		cmd = { 'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp', 'TmuxNavigateRight' },
		keys = {
			{ '<C-h>', '<cmd>TmuxNavigateLeft<cr>' },
			{ '<C-j>', '<cmd>TmuxNavigateDown<cr>' },
			{ '<C-k>', '<cmd>TmuxNavigateUp<cr>' },
			{ '<C-l>', '<cmd>TmuxNavigateRight<cr>' },
		},
	},
}
