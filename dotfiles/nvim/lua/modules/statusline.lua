local reset_group = vim.api.nvim_create_augroup('reset_group', {
  clear = false,
})
-- ==================
--     Statusline
-- ==================

vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'FocusGained' }, {
  desc = 'git branch and LSP errors for the statusline',
  callback = function()
    if vim.fn.isdirectory '.git' ~= 0 then
      -- always runs in the current directory, rather than in the buffer's directory
      local branch = vim.fn.system "git branch --show-current | tr -d '\n'"
      vim.b.branch_name = '  ' .. branch .. ' '
    end

    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    vim.b.errors = 'E:' .. num_errors .. ', ' .. 'W:' .. num_warnings

  end,
  group = init_group,
})

vim.opt.laststatus = 3 -- use global statusline
vim.opt.statusline =
  [[%#PmenuSel# %f %#LineNr#%{get(b:,"branch_name","")} %m %= %#CursorColumn# %{get(b:, "errors", "")} %y %p%% ]]
