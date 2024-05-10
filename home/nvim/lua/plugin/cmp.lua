return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
	},
	event = 'InsertEnter',
	opts = function()
		local cmp = require('cmp')
		local ls = require('luasnip')
		return {
			mapping = {
				['<c-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
				['<c-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
				['<c-u>'] = cmp.mapping.scroll_docs(4),
				['<c-d>'] = cmp.mapping.scroll_docs(-4),
				['<c-e>'] = cmp.mapping.abort(),
				['<tab>'] = cmp.config.disable,
				['<c-space>'] = cmp.mapping { i = cmp.mapping.complete() },
				['<c-y>'] = cmp.mapping(
					cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					},
					{ 'i', 'c' }
				),
				['<c-k>'] = cmp.mapping(function()
					if ls.expand_or_jumpable() then ls.expand_or_jump() end
				end, { 'i', 's' }),
				['<c-j>'] = cmp.mapping(function()
					if ls.jumpable(-1) then ls.jump(-1) end
				end, { 'i', 's' }),
				['<c-l>'] = cmp.mapping(function()
					if ls.choice_active() then ls.change_choice(1) end
				end),
			},
			sources = cmp.config.sources {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
			snippet = {
				expand = function(args) require('luasnip').lsp_expand(args.body) end,
			},
		}
	end,
}
