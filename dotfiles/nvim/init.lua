vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load base modules
require 'modules.mappings'
require 'modules.options'

if vim.g.vscode then
  -- do not load plugins
else
  -- Load more modules
  require 'modules.statusline'

  -- Load plugin configs
  require 'plugins'
  require 'plugins.treesitter'
  require 'plugins.lsp'
  require 'plugins.null-ls'
  require 'plugins.completion'
  require 'plugins.telescope'
  require 'plugins.git'
  require 'plugins.colorscheme'
  require 'plugins.misc'
end
