{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.gui.enable {
  home.packages = with pkgs; [
    vlc
  ];
}
