local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("go", {
  s("fn", fmt("func {}({}) {} \n\t{}\n", { i(1), i(2), i(3), i(4) })),
  s("fln", fmt("fmt.Println({})", { i(1) })),
  s("ff", fmt("fmt.Printf({})", { i(1) })),
})
