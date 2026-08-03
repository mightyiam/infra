{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.libreoffice-fresh];
    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 100 [pkgs.libreoffice-fresh];
  };
}
