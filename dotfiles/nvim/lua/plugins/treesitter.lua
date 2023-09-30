-- Configure Treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "typescript",
    "tsx",
    "lua",
    "rust",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  context_commentstring = {
    config = {
       javascript = {
          __default = '// %s',
          jsx_element = '{/* %s */}',
          jsx_fragment = '{/* %s */}',
          jsx_attribute = '// %s',
          comment = '// %s',
       },
       typescript = { __default = '// %s', __multiline = '/* %s */' },
   },
  },
}
