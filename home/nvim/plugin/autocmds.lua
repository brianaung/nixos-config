local create_autocmd = vim.api.nvim_create_autocmd
local creat_augroup = vim.api.nvim_create_augroup

create_autocmd({ "VimResized" }, {
	desc = "Resize splits if window got resized.",
	group = creat_augroup("resize_splits", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd "tabdo wincmd ="
		vim.cmd("tabnext " .. current_tab)
	end,
})

create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text.",
	group = creat_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

create_autocmd("BufEnter", {
	desc = "Set global format options.",
	group = creat_augroup("set_formatoptions", { clear = true }),
	callback = function()
		-- -o: Don't add comment leader when I press 'o' or 'O'.
		vim.opt.formatoptions:remove { "o" }
	end,
})

create_autocmd("FileType", {
	desc = "Close certain windows with the escape key.",
	group = creat_augroup("close_with_escape", { clear = true }),
	pattern = { "help", "qf", "man", "checkhealth" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "<esc>", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})
