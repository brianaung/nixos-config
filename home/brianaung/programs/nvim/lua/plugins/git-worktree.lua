return {
  "ThePrimeagen/git-worktree.nvim",
  keys = {
    {
      "<Leader>wc",
      function()
        vim.ui.input({ prompt = "Create worktree: " }, function(input)
          if type(input) == "string" then require("git-worktree").create_worktree(input) end
        end)
      end,
    },
    {
      "<Leader>ws",
      function()
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

        vim.ui.select(branches, {
          prompt = "Select worktree:",
        }, function(choice)
          if type(choice) == "string" then require("git-worktree").switch_worktree(choice) end
        end)
      end,
    },
    {
      "<Leader>wd",
      function()
        vim.ui.input({ prompt = "Delete worktree: " }, function(input)
          if type(input) == "string" then require("git-worktree").delete_worktree(input) end
        end)
      end,
    },
  },
}
