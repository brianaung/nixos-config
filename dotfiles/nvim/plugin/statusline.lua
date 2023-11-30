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
    local infos = "I"
      .. #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    local hints = "H"
      .. #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    ret = string.format("LSP: %s,%s,%s,%s", errors, warnings, infos, hints)
  end
  return ret
end

function GitBranch()
  local branch = vim.fn.systemlist("git branch --show-current")[1]
  if branch == "" then
    return ""
  end
  return string.format("[%s]", branch)
end

vim.opt.laststatus = 3
vim.opt.winbar = [[%=%m %f]]
vim.opt.statusline =
  [[%{luaeval("LspStatus()")} %=%<%t %{luaeval("GitBranch()")} %h%m%r %=%-14.(%l,%c%V%) %P]]
