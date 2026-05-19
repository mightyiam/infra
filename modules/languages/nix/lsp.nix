{
  flake.modules.nixvim.base = {
    plugins.lsp.servers.nixd = {
      enable = true;
      package = null;
    };
  };

  homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.nixd ];
    };
}
