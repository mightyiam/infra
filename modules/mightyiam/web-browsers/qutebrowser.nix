{lib, ...}: {
  home.gui = hmArgs: {
    config = {
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

      xdg.mimeApps.defaultApplications = lib.genAttrs [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "x-scheme-handler/file"
        "text/html"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ] (type: ["org.qutebrowser.qutebrowser.desktop"]);
    };
  };
}
