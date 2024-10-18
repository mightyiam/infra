{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.gui.enable {
  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
}
