local o = vim.opt
local get_mapper = function(mode)
	return function(lhs, rhs, opts)
		opts = opts or { noremap = true, silent = true }
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end
local nmap = get_mapper("n")
local imap = get_mapper("i")
local vmap = get_mapper("v")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

imap("kj", "<esc>")

nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")

nmap("<cr>", "<cmd>nohl<cr><cr>")

vmap("<leader>y", '"+y')
nmap("<leader>p", '"+p')

o.timeoutlen = 500

o.number = true
o.relativenumber = true

o.cursorline = true

o.tabstop = 2
o.shiftwidth = 2
-- o.softtabstop = 2
o.expandtab = false

o.ignorecase = true
o.smartcase = true

o.breakindent = true
o.showbreak = "   "
o.linebreak = true

o.termguicolors = true

o.completeopt = { "menuone", "noselect" }

o.formatoptions = o.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore
vim.cmd("au BufEnter * set fo-=o")

-- o.list = true
vim.cmd([[set listchars=tab:→\ ,eol:↲,extends:›,precedes:‹,nbsp:␣,trail:~]])

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- You can just do `require("lazy").setup("plugins")`,
-- But I want to have the ability to comment out just one line to temporarily disable them.
require("lazy").setup {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "go", "lua", "typescript" },
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
				},
			}
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local servers = {
				gopls = {},
				lua_ls = {},
				tsserver = {},
				tailwindcss = {},
			}

			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				nmap("<leader>gd", "<cmd>lua vim.lsp.buf.definition{}<cr>", opts)
				nmap("<leader>gr", "<cmd>lua vim.lsp.buf.references{}<cr>", opts)
				nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action{}<cr>", opts)
				nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				nmap("<leader>fmt", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
				nmap("K", "<cmd>lua vim.lsp.buf.hover{}<cr>", opts)
				nmap("<leader>sh", "<cmd>lua vim.lsp.buf.signature_help{}<cr>", opts)
				nmap("<leader>se", "<cmd>lua vim.diagnostic.open_float{}<cr>", opts)
				nmap("[d", "<cmd>lua vim.diagnostic.goto_prev{}<cr>", opts)
				nmap("]d", "<cmd>lua vim.diagnostic.goto_next{}<cr>", opts)
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}
			vim.diagnostic.config {
				float = { border = "rounded" },
			}

			require("mason").setup()
			require("mason-lspconfig").setup {
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup {
							capabilities = capabilities,
							on_attach = on_attach,
							handlers = handlers,
							settings = servers[server_name],
							filetypes = (servers[server_name] or {}).filetypes,
							init_options = (servers[server_name] or {}).init_options,
						}
					end,
				},
			}
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")

			cmp.setup {
				-- completion = { autocomplete = false }, -- i wanna trigger it myself
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item {
						behavior = cmp.SelectBehavior.Insert,
					},
					["<C-p>"] = cmp.mapping.select_prev_item {
						behavior = cmp.SelectBehavior.Insert,
					},
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ "i", "c" }
					),
					["<C-space>"] = cmp.mapping { i = cmp.mapping.complete() },
					["<tab>"] = cmp.config.disable,
					-- luasnip mappings
					["<C-k>"] = cmp.mapping(function()
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-j>"] = cmp.mapping(function()
						if ls.jumpable(-1) then
							ls.jump(-1)
						end
					end, { "i", "s" }),
					["<C-l>"] = cmp.mapping(function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end),
				},
				sources = cmp.config.sources {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			}

			-- luasnip config
			ls.config.set_config {
				history = true,
				updateevents = "TextChanged,TextChangedI",
			}
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup {
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = true,
					-- timeout_ms = 500,
				},
			}
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup {
				defaults = {
					mappings = {
						i = { ["<esc>"] = actions.close },
					},
				},
			}
			pcall(require("telescope").load_extension, "fzf")
			nmap("<leader>fd", "<cmd>lua require 'telescope.builtin'.find_files()<cr>")
			nmap("<leader>lg", "<cmd>lua require 'telescope.builtin'.live_grep()<cr>")
			nmap("<leader>fb", "<cmd>lua require 'telescope.builtin'.buffers()<cr>")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			nmap("<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>")
			nmap("<leader>h", "<cmd>lua require 'harpoon.ui'.toggle_quick_menu{}<cr>")
			for i = 1, 5 do
				nmap(string.format("<leader>%s", i), string.format("<cmd>lua require 'harpoon.ui'.nav_file(%s)<cr>", i))
			end
			nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
		end,
	},

	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup {
				mappings = {
					go_in = "",
					go_in_plus = "l",
				},
			}
			nmap("<leader>fe", "<cmd>lua MiniFiles.open()<cr>")
		end,
	},

	{
		"RRethy/nvim-base16",
		config = function()
			require("base16-colorscheme").with_config {
				telescope = false,
			}
		end,
		init = function()
			vim.cmd("colorscheme base16-gruvbox-material-dark-hard")
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			nmap("<leader>gs", "<cmd>G<cr>")
		end,
	},

	"tpope/vim-surround",

	{
		"mbbill/undotree",
		config = function()
			nmap("<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<cr>")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			}
		end,
	},
}
