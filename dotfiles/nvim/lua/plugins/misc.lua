-- Configs for miscellaneous plugins

-- /////start Comment config
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
-- /////end Comment config


-- /////start Telekasten config
local home = vim.fn.expand("~/notes")
require('telekasten').setup({
  home = home,

  templates = home .. '/' .. 'templates',
  template_new_note = home .. '/' .. 'templates/new-note.md',

  template_handling = 'prefer_new_note',
})

-- Launch panel if nothing is typed after <leader>z
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

-- Most used functions
vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
-- vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
-- vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
-- vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
-- vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

-- Call insert link automatically when we start typing a link
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
-- /////end Telekasten config


-- /////start Git Worktree config
--[[ local worktree = require('git-worktree')
worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    print("Switch from " .. metadata.prev_path .. " to " ..metadata.path)
  end
end) ]]
-- /////end Git Worktree config


-- /////start Lualine config
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
-- /////end Lualine config


-- /////start Nvim-Tmux navigator config
local nvim_tmux_nav = require('nvim-tmux-navigation')
nvim_tmux_nav.setup {
  -- disable_when_zoomed = true, -- defaults to false
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    last_active = "<C-\\>",
    next = "<C-Space>",
  }
}
-- /////end Nvim-Tmux navigator config


-- /////start Harpoon config
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
-- /////end Harpoon config
