return {
	'stevearc/oil.nvim',
	lazy = false,
	opts = {},
	cmd = { 'Oil', 'O' }, -- not rly necessary when lazy = false
	keys = {
		{
			'<leader>fe',
			function()
				if not pcall(vim.cmd, 'edit %:h') then vim.cmd('edit .') end
			end,
			-- or just use <cmd>Oil<cr> like a normal person
		},
	},
}
