{
  homeManager.modules.gui = {
    gtk.enable = true;
    qt.enable = true;
  };
  home.gui = hmArgs: {
    programs.qutebrowser.settings.qt.highdpi = true;
  };
}
