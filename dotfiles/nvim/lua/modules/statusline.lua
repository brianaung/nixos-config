local v = vim

local reset_group = v.api.nvim_create_augroup('reset_group', {
  clear = false,
})
-- ==================
--     Statusline
-- ==================

v.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'FocusGained' }, {
  desc = 'git branch and LSP errors for the statusline',
  callback = function()
    if v.fn.isdirectory '.git' ~= 0 then
      -- always runs in the current directory, rather than in the buffer's directory
      local branch = v.fn.system "git branch --show-current | tr -d '\n'"
      v.b.branch_name = '  ' .. branch .. ' '
    end

    local num_errors = #v.diagnostic.get(0, { severity = v.diagnostic.severity.ERROR })
    local num_warnings = #v.diagnostic.get(0, { severity = v.diagnostic.severity.WARN })
    v.b.errors = 'E:' .. num_errors .. ', ' .. 'W:' .. num_warnings

  end,
  group = init_group,
})

v.opt.laststatus = 3 -- use global statusline
v.opt.statusline =
  [[%#PmenuSel# %f %#LineNr#%{get(b:,"branch_name","")} %m %= %#CursorColumn# %{get(b:, "errors", "")} %y %p%% ]]
