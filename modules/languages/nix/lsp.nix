{
  flake.modules = {
    nixvim.astrea.plugins.lsp.servers.nixd.enable = true;

    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nixd ];
      };
  };
}
