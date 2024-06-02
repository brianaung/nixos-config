return {
	"stevearc/oil.nvim",
	opts = {
		keymaps = {
			["<esc>"] = "actions.close",
		},
	},
	cmd = { "Oil", "O" },
	keys = {
		{ "-", "<Cmd>Oil<CR>" },
	},
}
