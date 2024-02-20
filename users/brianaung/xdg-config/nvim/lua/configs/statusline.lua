local o = vim.opt
local if_nil = vim.F.if_nil
local function get_hl(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

o.laststatus = 0
-- o.winbar = "%= %<%t%h%m%r%w %{%%{luaeval('_G.diag()')}%}"
o.winbar = "%= %<%t%h%m%r%w"

(function()
	for key, val in pairs({
		["Error"] = {
			fg = if_nil(get_hl("DiagnosticError").fg, "red"),
			bg = get_hl("StatusLine").bg,
		},
		["Warn"] = {
			fg = if_nil(get_hl("DiagnosticWarn").fg, "yellow"),
			bg = get_hl("StatusLine").bg,
		},
		["Info"] = {
			fg = if_nil(get_hl("DiagnosticInfo").fg, "blue"),
			bg = get_hl("StatusLine").bg,
		},
		["Hint"] = {
			fg = if_nil(get_hl("DiagnosticHint").fg, "cyan"),
			bg = get_hl("StatusLine").bg,
		}
	}) do
		vim.api.nvim_set_hl(0, "Yasl" .. key, val)
	end
end)()

local function get_diagnostic_count(severity)
	return #vim.diagnostic.get(0, { severity = severity })
end

function _G.diag()
	local error_count = get_diagnostic_count(vim.diagnostic.severity.ERROR)
	local error = error_count > 0 and string.format("%%#YaslError#E%s%%* ", error_count) or ""

	local warn_count = get_diagnostic_count(vim.diagnostic.severity.WARN)
	local warn = warn_count > 0 and string.format("%%#YaslWarn#W%s%%* ", warn_count) or ""

	local info_count = get_diagnostic_count(vim.diagnostic.severity.INFO)
	local info = info_count > 0 and string.format("%%#YaslInfo#I%s%%* ", info_count) or ""

	local hint_count = get_diagnostic_count(vim.diagnostic.severity.HINT)
	local hint = hint_count > 0 and string.format("%%#YaslHint#H%s%%*", hint_count) or ""

	return string.format("%s%s%s%s", error, warn, info, hint)
end
