local set = vim.keymap.set

require("fzf-lua").setup {
  winopts = {
    preview = {
      hidden = "hidden",
    },
    backdrop = 100,
  },
  keymap = {
    builtin = {
      ["<Tab>"] = "toggle-preview",
      ["<C-u>"] = "preview-page-up",
      ["<C-d>"] = "preview-page-down",
    },
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
}
set("n", "<Leader>fd", "<Cmd>FzfLua files<CR>")
set("n", "<Leader>fl", "<Cmd>FzfLua live_grep<CR>")
set("n", "<Leader>fb", "<Cmd>FzfLua buffers<CR>")
set("n", "<Leader>fh", "<Cmd>FzfLua helptags<CR>")
