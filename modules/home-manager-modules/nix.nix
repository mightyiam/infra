{ pkgs, lib, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nixVersions.latest;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      keep-outputs = true;
    };
  };
  home.packages = with pkgs; [
    nix-fast-build
    nix-tree
    nixd
    nurl
    nvd
    statix
    nix-diff
    #nix-melt
    nix-prefetch-scripts
  ];
}
