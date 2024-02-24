return {
	'echasnovski/mini.files',
	version = '*',
	opts = {
		mappings = {
			close = '<esc>',
			go_in = '',
			go_in_plus = '<cr>',
			go_out = '',
			go_out_plus = '-',
		},
	},
	keys = {
		{ '<leader>fe', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end },
	},
}
