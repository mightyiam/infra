{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.vlc];
    xdg.mimeApps.defaultApplicationPackages = [pkgs.vlc];
  };
}
