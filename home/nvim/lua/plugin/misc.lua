return {
	'tpope/vim-sleuth',
	'tpope/vim-surround',
	'jwalton512/vim-blade',

	{
		'mbbill/undotree',
		cmd = { 'UndotreeShow', 'UndotreeToggle' },
		keys = {
			{ '<leader>u', '<cmd>UndotreeShow | UndotreeFocus<cr>' },
		},
		config = function()
			vim.api.nvim_create_autocmd('FileType', {
				desc = 'Close undotree buffer with the escape key',
				pattern = { 'undotree', 'diff' },
				group = vim.api.nvim_create_augroup('undotree_close_with_escape', { clear = true }),
				callback = function(event)
					vim.keymap.set('n', '<esc>', '<cmd>UndotreeHide<cr>', { buffer = event.buf, silent = true })
				end,
			})
		end,
	},

	{
		'tpope/vim-fugitive',
		cmd = { 'G', 'Git' },
		keys = {
			{ '<leader>gs', '<cmd>Git<cr>' },
		},
		config = function()
			vim.api.nvim_create_autocmd('FileType', {
				desc = 'Close fugitive buffer with the escape key',
				group = vim.api.nvim_create_augroup('close_with_escape', { clear = true }),
				pattern = { 'fugitive', 'fugitiveblame' },
				callback = function(event)
					vim.bo[event.buf].buflisted = false
					vim.keymap.set('n', '<esc>', '<cmd>close<cr>', { buffer = event.buf, silent = true })
				end,
			})
		end,
	},

	{
		'brianaung/yasl.nvim',
		opts = {},
	},

	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
		opts = {},
		cmd = { 'Gitsigns' },
	},

	{
		'christoomey/vim-tmux-navigator',
		cmd = { 'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp', 'TmuxNavigateRight' },
		keys = {
			{ '<c-h>', '<cmd>TmuxNavigateLeft<cr>' },
			{ '<c-j>', '<cmd>TmuxNavigateDown<cr>' },
			{ '<c-k>', '<cmd>TmuxNavigateUp<cr>' },
			{ '<c-l>', '<cmd>TmuxNavigateRight<cr>' },
		},
	},
}
