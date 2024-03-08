-- TODO: migration to harpoon 2?,
-- experimenting with tabline
return {
	'ThePrimeagen/harpoon',
	lazy = false, -- I want the tabline on right away
	keys = {
		{ '<leader>a', function() require('harpoon.mark').add_file() end },
		{ '<leader>h', function() require('harpoon.ui').toggle_quick_menu() end },
		{ '<leader>1', function() require('harpoon.ui').nav_file(1) end },
		{ '<leader>2', function() require('harpoon.ui').nav_file(2) end },
		{ '<leader>3', function() require('harpoon.ui').nav_file(3) end },
		{ '<leader>4', function() require('harpoon.ui').nav_file(4) end },
		{ '<leader>5', function() require('harpoon.ui').nav_file(5) end },
		{ '<leader>6', function() require('harpoon.ui').nav_file(6) end },
		{ '<C-n>', function() require('harpoon.ui').nav_next() end },
		{ '<C-p>', function() require('harpoon.ui').nav_prev() end },
	},
	opts = {
		tabline = true,
		tabline_prefix = ' [',
		tabline_suffix = '] ',
	},
	config = function(_, opts)
		require('harpoon').setup(opts)
		local hl = vim.api.nvim_get_hl(0, { name = "TabLineSel" })
		vim.api.nvim_set_hl(0, "HarpoonActive", hl)
		vim.api.nvim_set_hl(0, "HarpoonNumberActive", hl)
	end,
}
