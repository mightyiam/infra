{lib, ...}: {
  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      imv
      wl-color-picker
    ];

    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 50 [pkgs.imv];
  };
}
