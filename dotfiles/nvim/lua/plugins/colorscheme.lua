return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup {
      keywordStyle = { italic = false },
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      background = {
        dark = "dragon",
      },
    }
    vim.cmd([[
      colorscheme kanagawa
    ]])
  end,
}
