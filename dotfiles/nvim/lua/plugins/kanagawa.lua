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
              float = "none",
            },
          },
        },
      },
      overrides = function(_)
        return {
          TelescopePromptBorder = { bg = "none" },
          TelescopeResultsBorder = { bg = "none" },
          TelescopePreviewBorder = { bg = "none" },
        }
      end,
      theme = "dragon",
      background = {
        dark = "dragon",
      },
    }
    vim.cmd([[
      colorscheme kanagawa
    ]])
  end,
}
