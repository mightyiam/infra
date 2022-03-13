local nvim_lsp = require('lspconfig')

local mappings = {
  { 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {} },
  { 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {} },
  { 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {} },
  { 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {} },
  { 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {} },
  { 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', {} },
  { 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', {} },
  { 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', {} },
  { 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {} },
  { 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {} },
  { 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {} },
  { 'x', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', {} },
  { 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {} },
  { 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {} },
  { 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {} },
  { 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {} },
  { 'n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', {} },
  { 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {} },
}

for _, mapping in ipairs(mappings) do
  vim.api.nvim_set_keymap(unpack(mapping))
end

vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

local servers = { 'tsserver', 'rnix', 'sumneko_lua' }
for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup{} end

require('rust-tools').setup()
