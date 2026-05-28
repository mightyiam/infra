{
  flake.modules = {
    homeManager.base = {
      programs.nushell.enable = true;
    };
    nixvim.base = {
      lsp.servers.nushell = {
        enable = true;
        packageFallback = true;
      };
    };
  };
}
