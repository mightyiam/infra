{
  flake.modules = {
    nixvim.base.plugins.lsp.servers.nixd = {
      enable = true;
      package = null;
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      make-shells.default.packages = [ pkgs.nixd ];
    };
}
