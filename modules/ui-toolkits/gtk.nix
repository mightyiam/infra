{
  flake.modules.homeManager.gui = {
    gtk.enable = true;
    wayland.windowManager.sway.wrapperFeatures.gtk = true;
  };
}
