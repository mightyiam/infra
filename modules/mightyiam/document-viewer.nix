{
  home.gui = hmArgs: {
    programs.zathura.enable = true;
    xdg.mimeApps.defaultApplicationPackages = [hmArgs.config.programs.zathura.package];
  };
}
