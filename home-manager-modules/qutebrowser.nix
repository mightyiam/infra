{ config, lib, ... }:
{
  config = lib.mkIf config.gui.enable {
    programs.qutebrowser = {
      enable = true;

      keyBindings = {
        normal = {
          F = "hint all window";
          tf = "hint all tab";
        };
      };
    };

    wayland.windowManager.sway.config.keybindings."Mod4+q" =
      "exec ${lib.getExe config.programs.qutebrowser.package}";
  };
}
