return {
	"brianaung/yasl.nvim",
	-- dir = '~/projects/yasl.nvim',
	opts = {
		components = {
			"mode",
			" ",
			"%<%t%h%m%r%w", -- filename
			" ",
			"branch",
			" ",
			"gitdiff",
			"%=",
			"diagnostics",
			" ",
			"filetype",
			" ",
			"[%-8.(%l, %c%V%) %P]", -- location, and progress
			" ",
		},
	},
}
