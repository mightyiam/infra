{
  perSystem.treefmt.programs.yamlfmt.enable = true;

  flake.modules = {
    nixvim.base = {
      lsp.servers.yamlls = {
        enable = true;
        package = null;
      };
    };

    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.yaml-language-server ];
      };
  };

}
