{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.libreoffice-fresh];
    xdg.mimeApps.defaultApplicationPackages = [pkgs.libreoffice-fresh];
  };
}
