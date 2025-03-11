{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nix-fast-build
        nix-tree
        nvd
        nix-diff
      ];
      programs.nh.enable = true;
    };
}
