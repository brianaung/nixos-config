-- return {
--   "rebelot/kanagawa.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     transparent = true,
--     undercurl = false, -- enable undercurls
--     colors = {
--       palette = {
--         sumiInk0 = "#0d0c0c",
--         sumiInk1 = "#12120f",
--         sumiInk2 = "#1D1C19",
--         sumiInk3 = "#181616",
--         sumiInk4 = "#282727",
--         sumiInk5 = "#393836",
--         sumiInk6 = "#625e5a",
--       },
--     },
--     overrides = function(colors)
--       return {
--         LineNr = { bg = "none" },
--         SignColumn = { bg = "none" },
--       }
--     end,
--   },
--   config = function(_, opts)
--     require("kanagawa").setup(opts)
--     vim.cmd.colorscheme "kanagawa"
--   end,
-- }

return {
  "echasnovski/mini.base16",
  version = "*",
  lazy = false,
  priority = 1000,
  opts = {
    palette = {
      -- base00 = "#000000", -- default background
      -- base01 = "#000000", -- lighter background
      -- base02 = "#000000", -- selection background
      -- base03 = "#f5eee6", -- comments, invisibles
      -- base04 = "#f5eee6", -- dark foreground (statusbars)
      -- base05 = "#f5eee6", -- default foreground
      -- base06 = "#f5eee6", -- light foreground (not often used)
      -- base07 = "#f5eee6", -- light background (not often used)
      -- base08 = "#f5eee6", -- diff deleted
      -- base09 = "#f5eee6",
      -- base0A = "#f5eee6",
      -- base0B = "#f5eee6", -- diff inserted
      -- base0C = "#f5eee6",
      -- base0D = "#f5eee6",
      -- base0E = "#f5eee6", -- diff changed, keyword, italic
      -- base0F = "#f5eee6", -- deprecated

      base00 = "#181616",
      base01 = "#282727",
      base02 = "#223249",
      base03 = "#727169",
      base04 = "#C8C093",
      base05 = "#DCD7BA",
      base06 = "#938AA9",
      base07 = "#393836",
      base08 = "#C34043",
      base09 = "#FFA066",
      base0A = "#DCA561",
      base0B = "#98BB6C",
      base0C = "#7FB4CA",
      base0D = "#7E9CD8",
      base0E = "#957FB8",
      base0F = "#D27E99",
    },
  },
}
