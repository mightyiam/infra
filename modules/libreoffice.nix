{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = lib.mkOrder 30 [pkgs.libreoffice-fresh];
    xdg.mimeApps.defaultApplicationPackages = [pkgs.libreoffice-fresh];
  };
}
