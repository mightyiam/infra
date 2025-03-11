{
  flake.modules = {
    nixvim.astrea.plugins.lsp.servers.yamlls.enable = true;
    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ yaml-language-server ];
      };
  };

}
