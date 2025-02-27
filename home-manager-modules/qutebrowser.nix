{ config, lib, ... }:
{
  config = lib.mkIf config.gui.enable {
    programs.qutebrowser = {
      enable = true;

      loadAutoconfig = true;

      keyBindings = {
        normal = {
          F = "hint all window";
          tf = "hint all tab";
        };
      };

      settings.editor.command = [
        config.guiEditorCommand
        "{file}"
        "+{line}"
      ];
    };

    wayland.windowManager.sway.config.keybindings."Mod4+q" =
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
}
