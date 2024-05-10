-- Obsidian
return {
	'epwalsh/obsidian.nvim',
	version = '*',
	lazy = false,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'hrsh7th/nvim-cmp',
		'nvim-telescope/telescope.nvim',
		'nvim-treesitter/nvim-treesitter',
	},
	opts = {
		workspaces = {
			{
				name = 'personal',
				path = '~/vaults/personal',
			},
			{
				name = 'work',
				path = '~/vaults/work',
			},
		},
		daily_notes = {
			folder = 'dailies',
			date_format = '%Y-%m-%d',
			alias_format = '%B %-d, %Y',
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			local suffix = ''
			if title ~= nil then
				suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
			else
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. '-' .. suffix
		end,
	},
	keys = {
		{ '<leader>on', '<cmd>ObsidianNew<cr>' },
		{ '<leader>od', '<cmd>ObsidianDailies<cr>' },
		{ '<leader>ot', '<cmd>ObsidianTags<cr>' },
		{ '<leader>ob', '<cmd>ObsidianBacklinks<cr>' },
		{ '<leader>ow', '<cmd>ObsidianWorkspace<cr>' },
	},
}
