{ lib, ... }:
{
  flake.modules.homeManager.gui = hmArgs: {
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
          editor.command = [
            hmArgs.config.guiEditorCommand
            "{file}"
            "+{line}"
          ];
          tabs.tabs_are_windows = true;

          auto_save.session = true;
        };
      };

      wayland.windowManager = {
        hyprland.settings.bind = [
          "SUPER, q, exec, ${lib.getExe hmArgs.config.programs.qutebrowser.package}"
        ];

        sway.config.keybindings =
          let
            mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
          in
          {
            "--no-repeat ${mod}+q" = "exec ${lib.getExe hmArgs.config.programs.qutebrowser.package}";
          };
      };

      xdg.mimeApps.defaultApplications =
        [
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/chrome"
          "text/html"
          "application/x-extension-htm"
          "application/x-extension-html"
          "application/x-extension-shtml"
          "application/xhtml+xml"
          "application/x-extension-xhtml"
          "application/x-extension-xht"
        ]
        |> map (type: lib.nameValuePair type [ "org.qutebrowser.qutebrowser.desktop" ])
        |> lib.listToAttrs;
    };
  };
}
