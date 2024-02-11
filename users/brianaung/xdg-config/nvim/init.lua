vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- some globals
function P(v)
	vim.print(v)
	return v
end

function R(name)
	package.loaded[name] = nil
	return require(name)
end

require("configs.options")
require("configs.keymaps")

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

-- autocmd to close on esc for certain filetypes
-- same as defining for each ft in after/ftplugin/...
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"netrw",
		"qf",
		"man",
		"checkhealth",
		"fugitive",
		"fugitiveblame",
	},
	command = [[
		nnoremap <buffer><silent> <esc> :bd<cr>
		setl bufhidden=wipe
	]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"undotree",
	},
	command = [[
		nnoremap <buffer><silent> <esc> :UndotreeHide<cr>
	]],
})
