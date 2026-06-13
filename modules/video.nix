{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = lib.mkOrder 20 [pkgs.vlc];
    xdg.mimeApps.defaultApplicationPackages = [pkgs.vlc];
  };
}
