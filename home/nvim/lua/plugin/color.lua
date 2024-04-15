return {
	'rebelot/kanagawa.nvim',
	lazy = false,
	priority = 1000,
	opts = {
		undercurl = false, -- enable undercurls
	},
	config = function(_, opts)
		require('kanagawa').setup(opts)
		vim.cmd.colorscheme('kanagawa')
	end,
}
