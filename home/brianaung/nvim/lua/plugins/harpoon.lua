return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<Leader>a",
      function() require("harpoon.mark").add_file() end,
    },
    {
      "<Leader>h",
      function() require("harpoon.ui").toggle_quick_menu() end,
    },
    {
      "<Leader>1",
      function() require("harpoon.ui").nav_file(1) end,
    },
    {
      "<Leader>2",
      function() require("harpoon.ui").nav_file(2) end,
    },
    {
      "<Leader>3",
      function() require("harpoon.ui").nav_file(3) end,
    },
    {
      "<Leader>4",
      function() require("harpoon.ui").nav_file(4) end,
    },
    {
      "<Leader>5",
      function() require("harpoon.ui").nav_file(5) end,
    },
  },
}
