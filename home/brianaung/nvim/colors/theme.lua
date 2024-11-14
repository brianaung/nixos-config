if vim.g.colors_name ~= nil then vim.cmd "highlight clear" end
vim.g.colors_name = "theme"

local mode = vim.api.nvim_get_option_value("background", {})

-- Highlight groups
local hi = vim.api.nvim_set_hl

local black = 0
local red = 1
local green = 2
local yellow = 3
local blue = 4
local magenta = 5
local cyan = 6
local white = 7
local bright_black = 8
local bright_red = 9
local bright_green = 10
local bright_yellow = 11
local bright_blue = 12
local bright_magenta = 13
local bright_cyan = 14
local bright_white = 15

local bg, fg = black, white
local grey_1, grey_2 = 237, 242
if mode == "light" then
  bg, fg = white, black
  grey_1, grey_2 = 253, 250
end

-- Builtin highlighting groups. See :h highlight-groups

hi(0, "ColorColumn", { link = "CursorLine" })
hi(0, "Conceal", { bold = true })
hi(0, "CurSearch", { ctermbg = bright_yellow })
hi(0, "Cursor", { ctermfg = bg, ctermbg = fg }) -- no effect, handled by terminal
hi(0, "lCursor", { link = "Cursor" })
hi(0, "CursorIM", { link = "Cursor" })
hi(0, "CursorColumn", { link = "CursorLine" })
hi(0, "CursorLine", { ctermbg = grey_1 })
hi(0, "Directory", { ctermfg = blue }) -- TODO confirm color
hi(0, "DiffAdd", { ctermfg = bg, ctermbg = green, bold = true })
hi(0, "DiffChange", { ctermfg = bg, ctermbg = blue, bold = true })
hi(0, "DiffDelete", { ctermfg = bg, ctermbg = red, bold = true })
hi(0, "DiffText", { ctermfg = bg, ctermbg = bright_blue, bold = true })
hi(0, "EndOfBuffer", { link = "NonText" })
hi(0, "TermCursor", { link = "Cursor" })
hi(0, "TermCursorNC", { link = "TermCursor" })
hi(0, "ErrorMsg", { ctermfg = bright_red })
hi(0, "WinSeparator", {}) -- cleared
hi(0, "Folded", {}) -- TODO find color
hi(0, "FoldColumn", { link = "LineNr" })
hi(0, "SignColumn", { link = "LineNr" })
hi(0, "IncSearch", { link = "Search" })
hi(0, "Substitute", { link = "Search" })
hi(0, "LineNr", { ctermfg = fg })
hi(0, "LineNrAbove", { link = "LineNr" })
hi(0, "LineNrBelow", { link = "LineNr" })
hi(0, "CursorLineNr", { link = "CursorLine" })
hi(0, "CursorLineFold", { link = "CursorLine" })
hi(0, "CursorLineSign", { link = "CursorLine" })
hi(0, "MatchParen", { ctermbg = grey_2, underline = true })
hi(0, "ModeMsg", { bold = true })
hi(0, "MsgArea", {}) -- cleared
hi(0, "MsgSeparator", {}) -- cleared
hi(0, "MoreMsg", { ctermfg = green }) -- TODO confirm color
hi(0, "NonText", { ctermfg = grey_2 }) -- TODO confirm color
hi(0, "Normal", { ctermfg = fg, ctermbg = bg })
hi(0, "NormalFloat", { link = "Pmenu" })
-- TODO find color
hi(0, "FloatBorder", {})
hi(0, "FloatTitle", {})
hi(0, "FloatFooter", {})
-- **********
hi(0, "NormalNC", { link = "Normal" })
hi(0, "Pmenu", { ctermbg = grey_1 })
hi(0, "PmenuSel", { reverse = true })
hi(0, "PmenuKind", { link = "Pmenu" })
hi(0, "PmenuKindSel", { link = "PmenuSel" })
hi(0, "PmenuExtra", { link = "Pmenu" })
hi(0, "PmenuExtraSel", { link = "PmenuSel" })
hi(0, "PmenuSbar", { link = "Pmenu" })
hi(0, "PmenuThumb", { link = "PmenuSel" })
hi(0, "Question", { ctermfg = green }) -- TODO confirm color
hi(0, "QuickFixLine", { link = "Search" }) -- TODO confirm color
hi(0, "Search", { ctermbg = grey_2 }) -- TODO better contrast with comment
hi(0, "SnippetTabstop", {})
hi(0, "SpecialKey", { link = "NonText" })
-- TODO fix undercurl and sp color
hi(0, "SpellBad", { undercurl = true })
hi(0, "SpellCap", { undercurl = true })
hi(0, "SpellLocal", { undercurl = true })
hi(0, "SpellRare", { undercurl = true })
-- **********
hi(0, "StatusLine", { ctermbg = grey_1 })
hi(0, "StatusLineNC", {})
hi(0, "TabLine", { link = "StatusLine" })
hi(0, "TabLineFill", { link = "TabLine" })
hi(0, "TabLineSel", { reverse = true })
hi(0, "Title", { ctermfg = magenta, bold = true }) -- TODO confirm color
hi(0, "Visual", { ctermbg = grey_1 })
hi(0, "VisualNOS", { link = "Visual" })
hi(0, "WarningMsg", { ctermfg = bright_yellow })
hi(0, "Whitespace", { link = "NonText" })
hi(0, "WildMenu", { link = "Pmenu" })
hi(0, "WinBar", { link = "StatusLine" })
hi(0, "WinBarNC", { link = "StatusLineNC" })

hi(0, "Comment", { ctermfg = bright_black, italic = true })

hi(0, "Constant", { ctermfg = green }) -- TODO confirm color
hi(0, "String", { link = "Constant" })
hi(0, "Character", { link = "Constant" })
hi(0, "Number", { link = "Constant" })
hi(0, "Boolean", { link = "Constant" })
hi(0, "Float", { link = "Constant" })

hi(0, "Identifier", { ctermfg = mode == "light" and blue or cyan }) -- TODO confirm color
hi(0, "Function", { link = "Identifier" })

hi(0, "Statement", { ctermfg = red, bold = true }) -- TODO confirm color (red?)
hi(0, "Conditional", { link = "Statement" })
hi(0, "Repeat", { link = "Statement" })
hi(0, "Label", { link = "Statement" })
hi(0, "Operator", { link = "Statement" })
hi(0, "Keyword", { link = "Statement" })
hi(0, "Exception", { link = "Statement" })

hi(0, "PreProc", { ctermfg = magenta }) -- TODO confirm color
hi(0, "Include", { link = "PreProc" })
hi(0, "Define", { link = "PreProc" })
hi(0, "Macro", { link = "PreProc" })
hi(0, "PreCondit", { link = "PreProc" })

hi(0, "Type", { ctermfg = yellow, bold = true }) -- TODO confirm color
hi(0, "StorageClass", { link = "Type" })
hi(0, "Structure", { link = "Type" })
hi(0, "Typedef", { link = "Type" })

hi(0, "Special", {}) -- cleared
hi(0, "SpecialChar", { link = "Special" })
hi(0, "Tag", { link = "Special" })
hi(0, "Delimiter", { link = "Special" })
hi(0, "SpecialComment", { link = "Special" })
hi(0, "Debug", { link = "Special" })

hi(0, "Underlined", { underline = true })

hi(0, "Ignore", { link = "Normal" })

hi(0, "Error", { ctermfg = bright_white, ctermbg = bright_red })

hi(0, "Todo", { ctermfg = grey_2, bold = true })

hi(0, "Added", { link = "DiffAdd" })
hi(0, "Changed", { link = "DiffChange" })
hi(0, "Removed", { link = "DiffDelete" })
