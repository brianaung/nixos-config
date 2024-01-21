local nmap = require("utils.mapper").nmap

return {
	{
		-- "brianaung/yasl.nvim",
		dir = "~/projects/yasl.nvim",
		config = function()
			require("yasl").setup {
				sections = {
					A = { components = { "filename", "branch" } },
					C = { components = { "diagnostics", "gitdiff" } },
					D = { components = { "filetype" } },
					E = { components = { "location", "progress" } },
				},
			}
		end,
	},

	{
		"RRethy/nvim-base16",
		lazy = false,
		priority = 1000,
		config = function()
			require("base16-colorscheme").with_config {
				telescope = false,
			}
			vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
			vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "none" })
			vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "none" })
		end,
	},

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
		"ThePrimeagen/harpoon",
		config = function()
			nmap("<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>")
			nmap("<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu{}<cr>")
			for i = 1, 5 do
				nmap(string.format("<leader>%s", i), string.format("<cmd>lua require 'harpoon.ui'.nav_file(%s)<cr>", i))
			end
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
		cmd = {
			"UndotreeToggle",
			"UndotreeShow",
		},
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<cr>" },
		},
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
