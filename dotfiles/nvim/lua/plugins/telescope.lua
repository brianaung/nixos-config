local telescope = require('telescope')
local actions = require('telescope.actions')
local utils = require('telescope.utils')
local config = require('telescope.config')

-- /////start Create custom entry maker for find_files picker
local entry_display = require('telescope.pickers.entry_display')
local make_entry = require('telescope.make_entry')
local entry_make = make_entry.gen_from_file({})
local def_icon = require('nvim-web-devicons').get_icon('fname', { default = true })
local icon_width = require('plenary.strings').strdisplaywidth(def_icon)

-- return filename and the path given the full path
local get_path_and_tail = function(path)
  local tail = utils.path_tail(path)
  return tail, path
end

local entry_maker = function(line)
  local entry = entry_make(line)
  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = icon_width },
      { width = nil },
      { remaining = true },
    },
  })
  entry.display = function(et)
    local tail_raw, path_to_display = get_path_and_tail(et.value)
    local tail = tail_raw .. ' '
    local icon, iconhl = utils.get_devicons(tail_raw)

    return displayer({
      { icon, iconhl },
      tail,
      { path_to_display, 'TelescopeResultsComment' },
    })
  end
  return entry
end
-- /////end Create custom entry maker for find_files picker

-- /////start Search in hidden files and directories
if not table.unpack then
  table.unpack = unpack
end
local vimgrep_arguments = { table.unpack(config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")

-- But I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
-- /////end Search in hidden files and directories

telescope.setup {
  defaults = {
    vimgrep_arguments = vimgrep_arguments,

    sorting_strategy = "ascending",

    results_title = false,

    -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
      },
      vertical = {
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
      },
    },

    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },

    -- Simple result formatting
    path_display = function(_, path)
      local tail = utils.path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,

    -- files to ignore when fuzzy finding
    file_ignore_patterns = { "node_modules" },
  },

  pickers = {
    find_files = {
      entry_maker = entry_maker,
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
}

-- load extensions
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'file_browser')
pcall(telescope.load_extension, 'git_worktree')
pcall(telescope.load_extension, 'harpoon')
