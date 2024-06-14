{lib, ...}: let
  inherit (lib) elem;
in {
  programs.steam.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];
}
