local nmap = require("mapper").nmap

return {
  "ThePrimeagen/harpoon",
  config = function()
    nmap("<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>")
    nmap("<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu{}<cr>")
    for i = 1, 5 do
      nmap(
        string.format("<leader>%s", i),
        string.format("<cmd>lua require 'harpoon.ui'.nav_file(%s)<cr>", i)
      )
    end
    nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
  end,
}
