{
  flake.modules = {
    homeManager.base = {
      programs.nushell.enable = true;
    };
    nixvim.base = {
      plugins.lsp.servers.nushell = {
        enable = true;
        package = null;
      };
    };
  };
}
