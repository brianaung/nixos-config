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
-- /////end Telekasten config


-- /////start Git Worktree config
--[[ local worktree = require('git-worktree')
worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    print("Switch from " .. metadata.prev_path .. " to " ..metadata.path)
  end
end) ]]
-- /////end Git Worktree config


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
