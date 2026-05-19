{
  perSystem = {
    treefmt.programs = {
      nixf-diagnose.enable = true;

      statix.enable = true;
    };
  };

  flake.modules = {
    nixvim.base = {
      plugins.lsp.servers.statix = {
        enable = true;
        package = null;
      };
    };
    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.statix ];
      };
  };
}
