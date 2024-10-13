return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        hidden = "hidden",
      },
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
    files = {
      formatter = { "path.filename_first", 2 },
    },
    fzf_colors = true,
  },
  keys = {
    { "<Leader>fd", "<cmd>lua require('fzf-lua').files()<CR>" },
    { "<Leader>fl", "<cmd>lua require('fzf-lua').live_grep()<CR>" },
    { "<Leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>" },
    { "<Leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>" },
  },
}
