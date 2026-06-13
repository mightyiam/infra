{
  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      imv
      wl-color-picker
    ];

    xdg.mimeApps.defaultApplicationPackages = [pkgs.imv];
  };
}
