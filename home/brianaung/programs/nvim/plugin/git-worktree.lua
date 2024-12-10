local M = {}

M._ctx = {
  prev_dir = "",
}

function M.create_worktree()
  vim.ui.input({ prompt = "Create branch: " }, function(input)
    if type(input) ~= "string" then return end
    vim.system({ "git", "worktree", "add", input }, { text = true }, function(obj) vim.print(obj) end)
  end)
end

function M.switch_worktree()
  local obj = vim.system({ "git", "worktree", "list" }, { text = true }):wait()
  local lines = obj.stdout or ""
  local branches = vim
    .iter(lines:gmatch "[^\r\n]+")
    :map(function(l)
      local fields = vim.split(l:gsub("%s+", " "), " ")
      return fields[3] and fields[3]:gsub("[%[%]]", "")
    end)
    :filter(function(l) return l ~= nil end)
    :totable()

  vim.ui.select(branches, { prompt = "Select worktree:" }, function(choice)
    if type(choice) ~= "string" then return end

    if M._ctx.prev_dir ~= "" then
      vim.fn.chdir(M._ctx.prev_dir)
      M._ctx.prev_dir = ""
    end
    M._ctx.prev_dir = vim.fn.chdir(choice)

    vim.cmd "e ."
  end)
end

vim.keymap.set("n", "<Leader>wc", function() M.create_worktree() end)
vim.keymap.set("n", "<Leader>ws", function() M.switch_worktree() end)
