return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["<Esc>"] = "actions.close",
      ["<Tab>"] = "actions.preview",
    },
  },
  cmd = { "Oil", "O" },
  keys = {
    { "-", "<Cmd>Oil<CR>" },
  },
}
