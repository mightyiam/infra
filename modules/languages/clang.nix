{
  flake.modules.nixvim.base = {
    lsp.servers.clangd = {
      enable = true;
      package = null;
    };
  };
}
