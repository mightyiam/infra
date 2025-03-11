{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    lib.mkIf config.gui.enable {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;
      };
    };
}
