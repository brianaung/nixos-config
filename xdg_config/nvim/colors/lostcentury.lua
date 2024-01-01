require("mini.base16").setup {
  palette = {
    base00 = "#0B0C0D", -- ----
    base01 = "#141312", -- ---
    base02 = "#262321", -- --
    base03 = "#4D443E", -- -

    base04 = "#bdae93", -- +
    base05 = "#d5c4a1", -- ++
    base06 = "#ebdbb2", -- +++
    base07 = "#fbf1c7", -- ++++

    base08 = "#9E5961", -- red
    base09 = "#AE5D40", -- orange
    base0A = "#806A78", -- purple
    base0B = "#B3A555", -- green
    base0C = "#5D8C87", -- aqua/cyan
    base0D = "#8CABA1", -- blue
    base0E = "#BA9158", -- yellow
    base0F = "#4D4539", -- brown
  },
  use_cterm = nil,
  plugins = { default = false },
}
