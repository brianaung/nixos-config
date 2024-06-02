return {
	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git" },
		keys = {
			{ "<Leader>gs", "<Cmd>Git<CR>" },
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Close fugitive buffer with the escape key",
				group = vim.api.nvim_create_augroup("close_with_escape", { clear = true }),
				pattern = { "fugitive", "fugitiveblame" },
				callback = function(event)
					vim.bo[event.buf].buflisted = false
					vim.keymap.set("n", "<esc>", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
				end,
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
		cmd = { "Gitsigns" },
	},
}
