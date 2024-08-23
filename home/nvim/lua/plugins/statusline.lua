return {
  "brianaung/yasl.nvim",
  branch = "v2",
  -- dir = "~/projects/yasl.nvim",
  config = function()
    require("yasl").setup {
      components = {
        require "yasl.builtins.mode",
        "%#StatusLineNC# %<%t%h%m%r%w %*", -- filename
        require "yasl.builtins.gitbranch",
        require "yasl.builtins.diagnostic",
        "%=",
        require "yasl.builtins.gitdiff",
        "%#StatusLineNC# [%-8.(%l, %c%V%) %P] %*", -- location, and progress
      },
    }
  end,
}
