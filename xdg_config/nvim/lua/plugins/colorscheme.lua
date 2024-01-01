return {
  "echasnovski/mini.base16",
  version = "*",
  init = function()
    vim.cmd([[
      colorscheme lostcentury
      hi NormalFloat guibg=none
      hi FloatBorder guibg=none
    ]])
  end,
}
