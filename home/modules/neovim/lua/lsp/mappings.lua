local mappings = {
	{ "n", "gD", "vim.lsp.buf.declaration()" },
	{ "n", "gd", "vim.lsp.buf.definition()" },
	{ "n", "K", "vim.lsp.buf.hover()" },
	{ "n", "gi", "vim.lsp.buf.implementation()" },
	{ "n", "<C-k>", "vim.lsp.buf.signature_help()" },
	{ "n", "<space>wa", "vim.lsp.buf.add_workspace_folder()" },
	{ "n", "<space>wr", "vim.lsp.buf.remove_workspace_folder()" },
	{ "n", "<space>wl", "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))" },
	{ "n", "<space>D", "vim.lsp.buf.type_definition()" },
	{ "n", "<space>rn", "vim.lsp.buf.rename()" },
	{ "n", "<space>ca", "vim.lsp.buf.code_action()" },
	{ "x", "<space>ca", "vim.lsp.buf.range_code_action()" },
	{ "n", "gr", "vim.lsp.buf.references()" },
	{ "n", "<space>e", "vim.diagnostic.open_float()" },
	{ "n", "[d", "vim.diagnostic.goto_prev()" },
	{ "n", "]d", "vim.diagnostic.goto_next()" },
	{ "n", "<space>q", "vim.diagnostic.setloclist()" },
	{ "n", "<space>f", "vim.lsp.buf.formatting()" },
}

local function to_args(mapping)
	local mode = mapping[1]
	local lhs = mapping[2]
	local rhs = "<cmd>lua " .. mapping[3] .. "<CR>"
	local opts = { noremap = true }
	return unpack({ mode, lhs, rhs, opts })
end

return map(to_args, mappings)
