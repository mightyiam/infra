local servers = {
  'tsserver',
  'rnix',
  'rust-tools',
  'sumneko_lua',
}
for _, server in ipairs(servers) do require("lsp." .. server) end
