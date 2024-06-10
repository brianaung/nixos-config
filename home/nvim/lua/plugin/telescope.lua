return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	cmd = { "Telescope" },
	keys = {
		{
			"<Leader>fd",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<Leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<Leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<Leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
		{
			"<Leader>fc",
			function()
				require("telescope.builtin").commands()
			end,
		},
	},
	opts = function()
		return {
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					width = 0.9,
					height = 0.9,
					-- preview_cutoff = 30,
					horizontal = { preview_width = 0.5 },
				},
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		pcall(require("telescope").load_extension, "fzf")
	end,
}
