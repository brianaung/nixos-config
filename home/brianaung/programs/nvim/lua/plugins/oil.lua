return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["<Esc>"] = "actions.close",
    },
  },
  cmd = { "Oil", "O" },
  keys = {
    { "-", "<Cmd>Oil<CR>" },
  },
}
