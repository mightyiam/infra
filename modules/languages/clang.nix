{
  flake.modules.nixvim.base = {
    lsp.servers.clangd = {
      enable = true;
      packageFallback = true;
    };
  };
}
