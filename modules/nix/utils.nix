{ withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.system = pkgs.writeShellScriptBin "system" "nix-instantiate --eval --expr builtins.currentSystem";
    };
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nix-output-monitor
        nix-fast-build
        nix-tree
        nvd
        nix-diff
        (withSystem pkgs.system (psArgs: psArgs.config.packages.system))
      ];
      programs.nh.enable = true;
    };
}
