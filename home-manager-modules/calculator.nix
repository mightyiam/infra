{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = [ pkgs.bc ] ++ lib.optional config.gui.enable pkgs.qalculate-gtk;
}
