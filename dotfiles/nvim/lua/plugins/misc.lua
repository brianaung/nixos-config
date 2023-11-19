-- Configs for miscellaneous plugins

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
  javascript = {
    __default = '// %s',
    jsx_element = '{/* %s */}',
    jsx_fragment = '{/* %s */}',
    jsx_attribute = '// %s',
    comment = '// %s',
  },
  typescript = { __default = '// %s', __multiline = '/* %s */' },
}


--[[ local worktree = require('git-worktree')
worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    print("Switch from " .. metadata.prev_path .. " to " ..metadata.path)
  end
end) ]]


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
