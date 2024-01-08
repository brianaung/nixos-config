return
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
}
