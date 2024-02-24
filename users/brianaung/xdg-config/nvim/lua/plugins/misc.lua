return {
	'tpope/vim-surround',

	{ dir = '~/projects/yasl.nvim', opts = {} },

	{ 'j-hui/fidget.nvim', opts = {} },

	-- Git
	{
		'tpope/vim-fugitive',
		cmd = { 'G', 'Git' },
		keys = { { '<leader>gs', '<cmd>G<cr>' } },
	},

	{
		'lewis6991/gitsigns.nvim',
		opts = {},
		event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
		cmd = { 'Gitsigns' },
	},

	-- Code outline
	{
		'stevearc/aerial.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-telescope/telescope.nvim',
		},
		opts = {},
		cmd = { 'AerialOpen', 'AerialToggle', 'AerialPrev', 'AerialNext' },
		keys = { { '<leader>o', '<cmd>Telescope aerial<cr>' } },
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
