local nmap = require("utils.mapper").nmap

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local servers = {
			gopls = {},
			lua_ls = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
			nil_ls = {},
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

		-- completion
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
}
