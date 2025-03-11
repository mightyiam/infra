{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    lib.mkIf config.gui.enable {
      programs.zathura.enable = true;
      xdg.mimeApps.defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      };
    };
}
