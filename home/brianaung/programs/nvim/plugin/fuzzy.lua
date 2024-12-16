local function fuzzy(cmd, on_choice)
  local tmpfile = vim.fn.tempname()

  local tmpbuf = vim.api.nvim_create_buf(false, true)
  vim.bo[tmpbuf].bufhidden = "wipe"
  vim.bo[tmpbuf].modifiable = false

  local winid = vim.api.nvim_open_win(tmpbuf, false, {
    relative = "win",
    row = 0,
    col = 0,
    width = vim.api.nvim_win_get_width(0),
    height = vim.api.nvim_win_get_height(0),
  })
  vim.api.nvim_set_current_win(winid)

  vim.api.nvim_create_autocmd({ "TermOpen" }, {
    command = "startinsert!",
    once = true,
  })

  local args = {
    vim.o.shell,
    vim.o.shellcmdflag,
    string.format('%s > "%s"', cmd, tmpfile),
  }
  vim.api.nvim_buf_call(tmpbuf, function()
    vim.fn.termopen(args, {
      on_exit = function()
        local choice = nil
        local f = io.open(tmpfile)
        if f then
          choice = f:read "*a"
          f:close()
          os.remove(tmpfile)
        end
        on_choice(choice)
      end,
    })
  end)

  vim.api.nvim_create_autocmd("TermClose", {
    callback = function() pcall(vim.api.nvim_win_close, winid, false) end,
    once = true,
  })
end

vim.keymap.set("n", "<Leader>fd", function()
  fuzzy("fd --type file | fzf", function(choice)
    if choice and vim.trim(choice) ~= "" then vim.cmd("e " .. choice) end
  end)
end)

vim.keymap.set("n", "<Leader>fl", function()
  local rg_cmd = "rg --column --color=always --smart-case ''"
  local fzf_cmd =
    "fzf --ansi --delimiter : --nth 4.. --preview 'bat --color=always --number --highlight-line {2} {1}' --preview-window '+{2}/2,<80(up)' --bind='Tab:toggle-preview'"

  fuzzy(string.format("%s | %s", rg_cmd, fzf_cmd), function(choice)
    choice = string.match(choice, ".+:%d+:.+")
    if choice then
      local parts = vim.split(choice, ":")
      local path, line = parts[1], parts[2]
      vim.cmd("e +" .. line .. " " .. path)
    end
  end)
end)
