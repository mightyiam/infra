require("luafun.fun")()
local lsp_zero = require("lsp-zero")
lsp_zero.preset("system-lsp")
lsp_zero.setup_servers({
	"tsserver",
	"rnix",
	"sumneko_lua",
})
lsp_zero.set_preferences({
	set_lsp_keymaps = false,
})

lsp_zero.setup()
require("lsp.rust")(lsp_zero)
