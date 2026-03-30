{
  flake.modules.homeManager.wife = hmArgs: {
    gtk = {
      enable = true;

      # evaluation warning: The default value of `gtk.gtk4.theme` has changed from `config.gtk.theme` to `null`.
      #                     You are currently using the legacy default config.gtk.theme`) because `home.stateVersion` is less than "26.05".
      #                     To silence this warning and keep legacy behavior, set:
      #                       gtk.gtk4.theme = config.gtk.theme;
      #                     To adopt the new default behavior, set:
      #                       gtk.gtk4.theme = null;
      gtk4.theme = hmArgs.config.gtk.theme;
    };
  };
}
