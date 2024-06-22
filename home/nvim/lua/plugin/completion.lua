return {
  "brianaung/autocompl.nvim",
  -- dir = "~/projects/autocompl.nvim",
  opts = {},
  init = function()
    vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
    vim.opt.shortmess:append "c"

    vim.keymap.set("i", "<C-y>", function()
      if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
      if vim.fn.pumvisible() ~= 0 then return "<C-n><C-y>" end
      return "<C-y>"
    end, { expr = true })

    vim.keymap.set("i", "<CR>", function()
      if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
      if vim.fn.pumvisible() ~= 0 then return "<C-e><CR>" end
      return "<CR>"
    end, { expr = true })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if vim.snippet.active { direction = 1 } then return "<cmd>lua vim.snippet.jump(1)<cr>" end
    end, { expr = true })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if vim.snippet.active { direction = -1 } then return "<cmd>lua vim.snippet.jump(-1)<cr>" end
    end, { expr = true })
  end,
}
