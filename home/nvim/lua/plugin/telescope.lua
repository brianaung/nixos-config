return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	cmd = { 'Telescope' },
	keys = {
		{ '<leader>fd', function() require('telescope.builtin').find_files() end },
		{ '<leader>fg', function() require('telescope.builtin').live_grep() end },
		{ '<leader>fb', function() require('telescope.builtin').buffers() end },
		{ '<leader>fh', function() require('telescope.builtin').help_tags() end },
		{ '<leader>fc', function() require('telescope.builtin').commands() end },
	},
	opts = function()
		return {
			defaults = {
				layout_strategy = 'flex',
				layout_config = {
					width = 0.95,
					height = 0.95,
					-- preview_cutoff = 30,
					horizontal = { preview_width = 0.5 },
				},
			},
		}
	end,
	config = function(_, opts)
		require('telescope').setup(opts)
		pcall(require('telescope').load_extension, 'fzf')
	end,
}
