{lib, ...}: {
  home.gui = hmArgs: {
    # https://github.com/qutebrowser/qutebrowser/issues/8908
    home.sessionVariables.QTWEBENGINE_FORCE_USE_GBM = "0";

    programs.qutebrowser = {
      enable = true;

      loadAutoconfig = true;

      keyBindings.normal.e = "edit-url";

      extraConfig = ''
        config.unbind("d")
        config.unbind("D")
      '';

      settings = {
        # because neovide seems slow to start
        # https://github.com/neovide/neovide/discussions/3323
        editor.command = [
          hmArgs.config.terminal.path
          "--command"
          "nvim"
          "{file}"
          "+{line}"
        ];
        tabs.tabs_are_windows = true;

        auto_save.session = true;
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, q, exec, ${lib.getExe hmArgs.config.programs.qutebrowser.package}"
    ];

    xdg.mimeApps.defaultApplicationPackages = [hmArgs.config.programs.qutebrowser.package];
  };
}
