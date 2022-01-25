local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local function set_option(...) vim.api.nvim_set_option(...) end
set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
local opts = { noremap=true, silent=true }
set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
local nvim_lsp = require('lspconfig')
local servers = { 'tsserver', 'rnix', 'sumneko_lua' }
for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup{} end

