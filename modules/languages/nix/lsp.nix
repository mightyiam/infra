{
  flake.modules.nixvim.base = {
    lsp.servers.nixd = {
      enable = true;
      package = null;
    };
  };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.nixd ];
    };
}
