{lib, ...}: {
  home.gui = hmArgs: {
    programs.zathura.enable = true;
    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 15 [hmArgs.config.programs.zathura.package];
  };
}
