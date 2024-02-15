return {
	"tpope/vim-surround",

	{
		"brianaung/yasl.nvim",
		-- dir = "~/projects/yasl.nvim",
		config = function()
			require("yasl").setup {
				enable_icons = true,
			}
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
			}
		end,
	},

	-- Everything below is lazy loaded
	{
		"ThePrimeagen/harpoon",
		keys = {
			{ "<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>" },
			{ "<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu()<cr>" },
			{ "<leader>1", "<cmd>lua require 'harpoon.ui'.nav_file(1)<cr>" },
			{ "<leader>2", "<cmd>lua require 'harpoon.ui'.nav_file(2)<cr>" },
			{ "<leader>3", "<cmd>lua require 'harpoon.ui'.nav_file(3)<cr>" },
			{ "<leader>4", "<cmd>lua require 'harpoon.ui'.nav_file(4)<cr>" },
		},
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"fugitive",
					"fugitiveblame",
				},
				command = [[
					nnoremap <buffer><silent> <esc> :bd<cr>
					setl bufhidden=wipe
				]],
			})
		end,
		cmd = { "G", "Git" },
		keys = { { "<leader>gs", "<cmd>G<cr>" } },
	},

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				keymaps = {
					["<esc>"] = "actions.close",
				}
			})
		end,
		cmd = { "Oil" },
		keys = { { "<leader>fe", "<cmd>Oil<cr>" } },
	},

	{
		"mbbill/undotree",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "undotree" },
				command = [[ nnoremap <buffer><silent> <esc> :UndotreeHide<cr> ]],
			})
		end,
		cmd = {
			"UndotreeToggle",
			"UndotreeShow",
		},
		keys = { { "<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<cr>" } },
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			{ "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},
}
