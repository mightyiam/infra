{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.libreoffice-stable];
    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 100 [pkgs.libreoffice-stable];
  };
}
