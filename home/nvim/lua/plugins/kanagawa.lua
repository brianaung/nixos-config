local c = require "modules.colors"

-- I am happy to let kanagawa manage the highlight groups for now, while I only manage my colors
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colors = {
      theme = {
        all = {
          ui = {
            fg = c.White,
            fg_dim = c.BrightWhite,
            fg_reverse = c.Black,

            bg_dim = c.Black,
            bg_gutter = c.Black,

            bg_m3 = c.BrightBlack,
            bg_m2 = c.BrightBlack,
            bg_m1 = c.BrightBlack,
            bg = c.Black,
            bg_p1 = c.BrightBlack,
            bg_p2 = "none",

            special = c.BrightBlack,
            whitespace = c.BrightBlack,
            nontext = c.BrightBlack,

            bg_visual = c.Blue,
            bg_search = c.Blue,

            pmenu = {
              fg = c.Black,
              fg_sel = c.Black,
              bg = c.BrightMagenta,
              bg_sel = c.Magenta,
              bg_thumb = c.Black,
              bg_sbar = c.Black,
            },

            float = {
              fg = c.White,
              bg = "#252535",
              -- fg_border = c.White,
              -- bg_border = c.White,
            },
          },
          syn = {
            string = c.Green,
            variable = "none",
            number = c.BrightMagenta,
            constant = c.BrightYellow,
            identifier = c.Yellow,
            parameter = c.White,
            fun = c.Blue,
            statement = c.Magenta,
            keyword = c.Magenta,
            operator = c.BrightWhite,
            preproc = c.Red,
            type = c.Cyan,
            regex = c.Red,
            deprecated = c.BrightBlack,
            punct = c.BrightWhite,
            comment = c.BrightBlack,
            special1 = c.Cyan,
            special2 = c.Red,
            special3 = c.Red,
          },
          diag = {
            error = c.BrightRed,
            ok = c.BrightGreen,
            warning = c.BrightYellow,
            info = c.BrightBlue,
            hint = c.BrightCyan,
          },
          -- diff = {
          --   add = c.Green,
          --   delete = c.Red,
          --   change = c.Blue,
          --   text = c.Yellow,
          -- },
          -- vcs = {
          --   added = c.BrightGreen,
          --   removed = c.BrightRed,
          --   changed = c.BrightYellow,
          -- },
          term = {
            c.Black, -- black
            c.Red, -- red
            c.Green, -- green
            c.Yellow, -- yellow
            c.Blue, -- blue
            c.Magenta, -- magenta
            c.Cyan, -- cyan
            c.White, -- white
            c.BrightBlack, -- bright black
            c.BrightRed, -- bright red
            c.BrightGreen, -- bright green
            c.BrightYellow, -- bright yellow
            c.BrightBlue, -- bright blue
            c.BrightMagenta, -- bright magenta
            c.BrightCyan, -- bright cyan
            c.BrightWhite, -- bright white
            c.Yellow, -- extended color 1
            c.Yellow, -- extended color 2
          },
        },
      },
    },
  },
  init = function() vim.cmd "colorscheme kanagawa" end,
}
