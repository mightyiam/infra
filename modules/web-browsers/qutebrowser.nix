{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { config, ... }:
    {
      config = {
        programs.qutebrowser = {
          enable = true;

          loadAutoconfig = true;

          keyBindings.normal.e = "edit-url";

          settings = {
            editor.command = [
              config.guiEditorCommand
              "{file}"
              "+{line}"
            ];
            tabs.tabs_are_windows = true;

            # https://github.com/qutebrowser/qutebrowser/issues/8535
            qt.force_software_rendering = "chromium";

            auto_save.session = true;
          };

        };

        wayland.windowManager.sway.config.keybindings."--no-repeat Mod4+q" =
          "exec ${lib.getExe config.programs.qutebrowser.package}";

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
