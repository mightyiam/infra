{ config, lib, ... }:
let
  image = [ "imv.desktop" ];
in
lib.mkIf config.gui.enable {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = image;
      };
    };
  };
}
