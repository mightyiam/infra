{ config, lib, ... }:
lib.mkIf config.gui.enable {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
  };
}
