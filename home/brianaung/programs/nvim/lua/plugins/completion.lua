return {
  "brianaung/compl.nvim",
  -- dir = "~/projects/compl.nvim",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    snippet = {
      paths = {
        vim.fn.stdpath "data" .. "/lazy/friendly-snippets",
      },
    },
  },
}
