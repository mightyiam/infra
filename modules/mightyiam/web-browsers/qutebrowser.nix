{lib, ...}: {
  # https://github.com/NixOS/nixpkgs/pull/584791
  perSystem.nixpkgs.config.permittedInsecurePackages = ["qutebrowser-3.7.0"];

  home.gui = hmArgs: {
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
        input.insert_mode.auto_leave = false;
        content.blocking.enabled = false;
        downloads.position = "bottom";
        scrolling.smooth = true;
        url.default_page = "https://grok.com/";
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + q"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe hmArgs.config.programs.qutebrowser.package}")'')
        ];
      }
    ];

    xdg.mimeApps.defaultApplicationPackages = [hmArgs.config.programs.qutebrowser.package];
  };
}
