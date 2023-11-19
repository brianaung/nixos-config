local v = vim

v.api.nvim_create_autocmd({ 'BufEnter', 'DiagnosticChanged' }, {
  desc = 'Git branch and LSP errors for the statusline',
  callback = function()
    if v.fn.isdirectory '.git' ~= 0 then
      -- always runs in the current directory, rather than in the buffer's directory
      local branch = v.fn.system "git branch --show-current | tr -d '\n'"
      v.b.branch_name = branch
    end

    local clients = v.lsp.get_active_clients({ buffer = 0 })
    -- if no clients attached or only copilot is attached then show off status
    if #clients == 0 or (#clients == 1 and clients[1].name == 'copilot') then
      v.b.lsp_status = 'LSP: Off'
    else
      local num_errors = #v.diagnostic.get(0, { severity = v.diagnostic.severity.ERROR })
      local num_warnings = #v.diagnostic.get(0, { severity = v.diagnostic.severity.WARN })
      local num_infos = #v.diagnostic.get(0, { severity = v.diagnostic.severity.INFO })
      local num_hints = #v.diagnostic.get(0, { severity = v.diagnostic.severity.HINT })
      v.b.lsp_status = 'LSP: ' .. 'E' .. num_errors .. ', ' .. 'W' .. num_warnings .. ', ' .. 'I' .. num_infos .. ', ' .. 'H' .. num_hints
    end

  end,
})

v.opt.laststatus = 3 -- use global statusline
v.opt.statusline =
  [[%{get(b:,"lsp_status","")} %=%<%t [%{get(b:,"branch_name","")}] %h%m%r %=%-14.(%l,%c%V%) %P]]
v.opt.winbar = [[%=%m %f]]
