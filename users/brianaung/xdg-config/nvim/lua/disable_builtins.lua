local disable_builtin = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",

	-- "gzip",
	-- "zip",
	-- "zipPlugin",
	-- "tar",
	-- "tarPlugin",

	-- "getscript",
	-- "getscriptPlugin",
	-- "vimball",
	-- "vimballPlugin",
	-- "2html_plugin",

	-- "logipat",
	-- "rrhelper",
	-- "spellfile_plugin",
	-- "matchit",
}

for _, plugin in pairs(disable_builtin) do
	vim.g["loaded_" .. plugin] = 1
end
