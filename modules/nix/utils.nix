{
  flake.modules.homeManager.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cachix
        nix-fast-build
        nix-tree
        nvd
        nix-diff
      ];
      programs.nh.enable = true;
    };
}
