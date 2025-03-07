{
  flake.modules = {
    nixvim.astrea.plugins.lsp.servers.yamlls.enable = true;
    homeManager.home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ yaml-language-server ];
      };
  };

}
