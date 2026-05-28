{
  flake.modules.nixvim.base = {
    lsp.servers.nixd = {
      enable = true;
      packageFallback = true;
    };
  };
}
