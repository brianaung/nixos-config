local M = {}

local get_mapper = function(mode)
	return function(lhs, rhs, opts)
		opts = opts or { noremap = true, silent = true }
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

M.nmap = get_mapper("n")
M.imap = get_mapper("i")
M.vmap = get_mapper("v")
M.xmap = get_mapper("x")

return M
