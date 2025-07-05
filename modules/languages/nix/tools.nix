{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        #nix-melt
        nix-prefetch-scripts
        nurl
      ];
    };
}
