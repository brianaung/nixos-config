return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		undercurl = false, -- enable undercurls
		colors = {
			palette = {
				sumiInk0 = "#0d0c0c",
				sumiInk1 = "#12120f",
				sumiInk2 = "#1D1C19",
				sumiInk3 = "#181616",
				sumiInk4 = "#282727",
				sumiInk5 = "#393836",
				sumiInk6 = "#625e5a",
			},
		},
		overrides = function(colors)
			return {
				-- NormalFloat = { link = "Pmenu" },
				LineNr = { bg = "none" },
				SignColumn = { bg = "none" },
				-- TelescopePromptBorder = { fg = colors.palette.fujiWhite, bg = "none" },
				-- TelescopeResultsBorder = { fg = colors.palette.fujiWhite, bg = "none" },
				-- TelescopePreviewBorder = { fg = colors.palette.fujiWhite, bg = "none" },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd.colorscheme "kanagawa"
	end,
}
