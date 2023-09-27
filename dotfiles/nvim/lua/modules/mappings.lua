-- util for assigning mapping type
local get_mapper = function(mode, noremap)
  return function(lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = noremap
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- local noremap = get_mapper("n", false)
local nnoremap = get_mapper("n", true)
local inoremap = get_mapper("i", true)
-- local tnoremap = get_mapper("t", true)
-- local vnoremap = get_mapper("v", true)

inoremap("kj", "<esc>")
-- better movement between lines
nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("gj", "j")
nnoremap("gk", "k")
-- remove search highlight
nnoremap("<cr>", "<cmd>nohl<cr><cr>")
