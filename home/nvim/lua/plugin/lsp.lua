return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		-- "hrsh7th/cmp-nvim-lsp",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		servers = {
			lua_ls = {
				Lua = { diagnostics = { globals = { "vim" } } },
			},
			nil_ls = {},
			gopls = {},
			pyright = {},
			tsserver = {},
			tailwindcss = {},
			phpactor = {},
			volar = {},
		},
		on_attach = function(_, bufnr)
			local opts = { buffer = bufnr }
			local set = vim.keymap.set
			set("n", "<Leader>gd", require("telescope.builtin").lsp_definitions, opts)
			set("n", "<Leader>gr", require("telescope.builtin").lsp_references, opts)
			set("n", "<Leader>gi", require("telescope.builtin").lsp_implementations, opts)
			set("n", "<Leader>gt", require("telescope.builtin").lsp_type_definitions, opts)
			set("n", "<Leader>le", require("telescope.builtin").diagnostics, opts)
			set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
			set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
			set("n", "K", vim.lsp.buf.hover, opts)
			set("n", "<Leader>sh", vim.lsp.buf.signature_help, opts)
			set("n", "<Leader>se", vim.diagnostic.open_float, opts)
			set("n", "[d", vim.diagnostic.goto_prev, opts)
			set("n", "]d", vim.diagnostic.goto_next, opts)
		end,
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	},
	config = function(_, opts)
		-- opts.capabilities = require("cmp_nvim_lsp").default_capabilities(opts.capabilities)
		for server, server_opts in pairs(opts.servers) do
			require("lspconfig")[server].setup {
				capabilities = opts.capabilities,
				on_attach = opts.on_attach,
				settings = server_opts,
				filetypes = (server_opts or {}).filetypes,
				init_options = (server_opts or {}).init_options,
			}
		end
	end,
}
