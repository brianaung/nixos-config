return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		cmd = { 'Telescope' },
		keys = {
			{ '<leader>fd', function() require('telescope.builtin').find_files() end },
			{ '<leader>lg', function() require('telescope.builtin').live_grep() end },
			{ '<leader>fb', function() require('telescope.builtin').buffers() end },
			{ '<leader>fh', function() require('telescope.builtin').help_tags() end },
		},
		opts = function()
			local actions = require('telescope.actions')
			return {
				defaults = {
					-- mappings = { i = { ['<esc>'] = actions.close } },
					layout_strategy = 'flex',
					layout_config = {
						width = 0.95,
						height = 0.95,
						preview_cutoff = 30,
						prompt_position = 'top',
						horizontal = { preview_width = 0.5 },
					},
				},
			}
		end,
		config = function(_, opts)
			require('telescope').setup(opts)
			pcall(require('telescope').load_extension, 'fzf')
		end,
	},

	-- Undotree
	{
		'debugloop/telescope-undo.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		opts = function()
			local actions = require('telescope-undo.actions')
			return {
				extensions = {
					undo = {
						mappings = { i = { ['<cr>'] = actions.restore } },
					},
				},
			}
		end,
		config = function(_, opts)
			require('telescope').setup(opts)
			pcall(require('telescope').load_extension, 'undo')
		end,
		keys = { { '<leader>u', '<cmd>Telescope undo<cr>' } },
	},
}
