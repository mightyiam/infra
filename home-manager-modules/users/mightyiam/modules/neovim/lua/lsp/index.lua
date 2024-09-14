require("luafun.fun")()
local lsp_zero = require("lsp-zero")
lsp_zero.preset("system-lsp")
lsp_zero.setup_servers({
	"eslint",
	"lua_ls",
	"nixd",
	"ts_ls",
	"yamlls",
})
lsp_zero.set_preferences({
	set_lsp_keymaps = false,
})

require("lsp.lua")(lsp_zero)

lsp_zero.setup()
