return {
  "mbbill/undotree",
  cmd = { "UndotreeShow", "UndotreeToggle" },
  keys = {
    { "<Leader>u", "<Cmd>UndotreeShow | UndotreeFocus<CR>" },
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Close undotree buffer with the escape key",
      pattern = { "undotree", "diff" },
      group = vim.api.nvim_create_augroup("undotree_close_with_escape", { clear = true }),
      callback = function(event)
        vim.keymap.set("n", "<Esc>", "<Cmd>UndotreeHide<CR>", { buffer = event.buf, silent = true })
      end,
    })
  end,
}
