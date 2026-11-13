{lib, ...}: {
  users.bow.home.gui = hmArgs @ {pkgs, ...}: {
    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 10 [hmArgs.config.programs.chromium.package];

    home.packages = [
      pkgs.chromium
      pkgs.firefox
    ];
  };
}
