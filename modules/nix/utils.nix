{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nix-output-monitor
        nix-fast-build
        nix-tree
        nvd
        nix-diff
      ];
      programs.nh.enable = true;
    };
}
