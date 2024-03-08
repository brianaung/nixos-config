return {
	'rebelot/kanagawa.nvim',
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		colors = {
			palette = {
				sumiInk0 = '#0d0c0c',
				sumiInk1 = '#12120f',
				sumiInk2 = '#1D1C19',
				sumiInk3 = '#181616',
				sumiInk4 = '#282727',
				sumiInk5 = '#393836',
				sumiInk6 = '#625e5a',
			},
			theme = {
				all = {
					ui = {
						bg_gutter = 'none',
						float = { bg = '#223249' },
					},
				},
			},
		},
		overrides = function(colors)
			return {
				WinSeparator = { fg = colors.theme.ui.fg, bg = colors.theme.ui.bg_m2 },
				TelescopeBorder = { fg = colors.theme.ui.fg, bg = colors.theme.ui.bg_m2 },
			}
		end,
	},
	config = function(_, opts)
		require('kanagawa').setup(opts)
		vim.cmd('colorscheme kanagawa')
	end,
}
