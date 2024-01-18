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

-- autocmds
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"netrw",
		"qf",
		"man",
		"checkhealth",
	},
	command = [[
		nnoremap <buffer><silent> <esc> :bd<CR>
		setl bufhidden=wipe
	]],
})
