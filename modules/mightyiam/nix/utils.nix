{
  lib,
  withSystem,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.system = pkgs.writeShellScriptBin "system" "nix-instantiate --eval --expr builtins.currentSystem --raw";
  };
  home.base = {pkgs, ...}: {
    home.packages =
      (with pkgs; [
        nix-diff
        nix-du
        nix-fast-build
        nix-melt
        nix-output-monitor
        nix-prefetch-scripts
        nix-tree
        nurl
        nvd
      ])
      ++ [
        # TODO from overlay
        (withSystem pkgs.stdenv.hostPlatform.system (psArgs: psArgs.config.packages.system))
      ];
    programs = {
      nh.enable = true;
      zsh.shellAliases.nix-shell = "nix-shell --run ${lib.getExe pkgs.zsh}";
    };
  };
}
