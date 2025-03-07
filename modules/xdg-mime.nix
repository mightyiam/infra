{ lib, ... }:
{
  flake.modules.homeManager.home =
    { config, ... }:
    lib.mkIf config.gui.enable {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;
      };
    };
}
