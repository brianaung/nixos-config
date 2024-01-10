local nmap = require("utils.mapper").nmap

return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup {
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = true,
					-- timeout_ms = 500,
				},
			}
		end,
	},

	{
		'stevearc/dressing.nvim',
		opts = {},
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			nmap("<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>")
			nmap("<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu{}<cr>")
			for i = 1, 5 do
				nmap(string.format("<leader>%s", i),
					string.format("<cmd>lua require 'harpoon.ui'.nav_file(%s)<cr>", i))
			end
		end,
	},

	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup {
				mappings = {
					go_in = "",
					go_in_plus = "l",
					close = "<esc>",
				},
			}
			nmap("<leader>fe", "<cmd>lua MiniFiles.open()<cr>")
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			nmap("<leader>gs", "<cmd>G<cr>")
		end,
	},

	"tpope/vim-surround",

	{
		"mbbill/undotree",
		config = function()
			nmap("<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<cr>")
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
			}
		end,
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
