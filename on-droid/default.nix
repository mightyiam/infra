{
  config,
  pkgs,
  lib,
  ...
}: {
  system.stateVersion = "23.05";
  time.timeZone = "Asia/Bangkok";
  home-manager.useGlobalPkgs = true;
  home-manager.imports = [../home/home.nix];
  user.shell = "${pkgs.zsh}/bin/zsh";
}
