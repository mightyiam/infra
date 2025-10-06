{
  perSystem.treefmt.programs.yamlfmt.enable = true;

  flake.modules = {
    nixvim.base.plugins.lsp.servers.yamlls.enable = true;
    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ yaml-language-server ];
      };
  };

}
