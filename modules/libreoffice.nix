{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.libreoffice-fresh];
    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 30 [pkgs.libreoffice-fresh];
  };
}
