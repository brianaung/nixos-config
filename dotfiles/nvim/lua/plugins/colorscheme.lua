return {
  "echasnovski/mini.base16",
  version = "*",
  init = function()
    vim.cmd([[
      colorscheme myscheme
      hi Pmenu guibg=#3B2B36
      hi NormalFloat guibg=#3B2B36
    ]])
  end,
}
