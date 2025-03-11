{
  flake.modules = {
    nixvim.astrea.plugins.lsp.servers.nixd.enable = true;
    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          #nix-melt
          nix-prefetch-scripts
          nixd
          nurl
          statix
        ];
      };
  };
}
