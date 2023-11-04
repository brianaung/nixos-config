-- require('poimandres').setup {
--   disable_background = true,
--   disable_italics = false,
-- }

-- require('rose-pine').setup {
--   variant = 'main',
--   disable_italics = true,
--   disable_background = true,
--   disable_float_background = true,
-- }

-- vim.cmd("colorscheme poimandres")
-- vim.cmd("colorscheme rose-pine")

require('colorbuddy').colorscheme('gruvbuddy')

-- manually overriding gruvbuddy
-- vim.cmd[[
-- hi LineNr none
-- hi SignColumn none
-- hi Normal guibg=#111111
-- ]]
