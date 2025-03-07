{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      pkgs,
      config,
      ...
    }:
    lib.mkMerge [
      (lib.mkIf config.gui.enable {
        home.packages = with pkgs; [
          gimp
          imv
          inkscape
        ];
        xdg.mimeApps.defaultApplications = {
          # TODO more image formats
          "image/png" = [ "imv.desktop" ];
        };
      })
    ];
}
