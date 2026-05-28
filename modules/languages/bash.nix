{
  flake.modules.nixvim.base = {
    lsp.servers.bashls = {
      enable = true;
      package = null;
    };
  };
}
