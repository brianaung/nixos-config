return {
	{
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			transparent_mode = true,
			invert_selection = true,
			underline = false,
			contrast = 'hard',
			overrides = {
				LineNr = { fg = '#5eacd3' },
				CursorLine = { bg = 'none' },
				CursorLineNr = { bg = 'none' },
			},
		},
		config = function(_, opts)
			require('gruvbox').setup(opts)
			vim.cmd.colorscheme('gruvbox')
		end,
	},
}
