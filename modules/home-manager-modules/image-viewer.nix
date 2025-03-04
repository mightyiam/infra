{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.gui.enable {
  home.packages = [ pkgs.imv ];
  xdg.mimeApps.defaultApplications = {
    "image/png" = [ "imv.desktop" ];
  };
}
