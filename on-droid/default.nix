{
  config,
  pkgs,
  lib,
  ...
}: let
  home = import ../home/home.nix;
  instance = {
    features = ["tui"];
  };
in {
  system.stateVersion = "23.05";
  time.timeZone = "Asia/Bangkok";
  home-manager.useGlobalPkgs = true;
  home-manager.config = home instance;
  user.shell = "${pkgs.zsh}/bin/zsh";
}
