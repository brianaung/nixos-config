return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        hidden = "hidden",
      },
      backdrop = 100,
    },
    keymap = {
      builtin = {
        -- using builtin previewer, define these inside fzf if using bat
        ["<Tab>"] = "toggle-preview",
        ["<C-u>"] = "preview-page-up",
        ["<C-d>"] = "preview-page-down",
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
  },
  keys = {
    { "<Leader>fd", "<Cmd>lua require('fzf-lua').files()<CR>" },
    { "<Leader>fl", "<Cmd>lua require('fzf-lua').live_grep()<CR>" },
    { "<Leader>fb", "<Cmd>lua require('fzf-lua').buffers()<CR>" },
    { "<Leader>fh", "<Cmd>lua require('fzf-lua').help_tags()<CR>" },
  },
}
