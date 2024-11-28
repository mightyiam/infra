{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.gui.enable {
  home.packages = [ pkgs.qalculate-gtk ];
}
