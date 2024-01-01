local o = vim.opt

-- custom statusline
function LspStatus()
  local ret = ""
  local clients = vim.lsp.get_active_clients { buffer = 0 }
  if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then
    ret = "LSP: Off"
  else
    local errors = "E"
      .. #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = "W"
      .. #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    ret = string.format("LSP: %s,%s", errors, warnings)
  end
  return ret
end

o.laststatus = 3
o.statusline =
  [[%{luaeval("LspStatus()")} %=%<%t %{FugitiveStatusline()} %h%m%r %=%-14.(%l,%c%V%) %P]]
