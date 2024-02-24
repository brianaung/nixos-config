return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'nvim-telescope/telescope.nvim',
	},
	opts = {
		servers = {
			lua_ls = {
				Lua = { diagnostics = { globals = { 'vim' } } },
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
			vim.keymap.set('n', '<leader>gd', require('telescope.builtin').lsp_definitions, opts)
			vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, opts)
			vim.keymap.set('n', '<leader>gi', require('telescope.builtin').lsp_implementations, opts)
			vim.keymap.set('n', '<leader>gt', require('telescope.builtin').lsp_type_definitions, opts)
			vim.keymap.set('n', '<leader>ld', require('telescope.builtin').diagnostics, opts)
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'sh', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float, opts)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		end,
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	},
	config = function(_, opts)
		opts.capabilities = require('cmp_nvim_lsp').default_capabilities(opts.capabilities)
		for server, server_opts in pairs(opts.servers) do
			require('lspconfig')[server].setup {
				capabilities = opts.capabilities,
				on_attach = opts.on_attach,
				settings = server_opts,
				filetypes = (server_opts or {}).filetypes,
				init_options = (server_opts or {}).init_options,
			}
		end
	end,
}
