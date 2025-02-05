{ config, lib, ... }:
{
  config = lib.mkIf config.gui.enable {
    programs.qutebrowser = {
      enable = true;
    };

    wayland.windowManager.sway.config.keybindings."Mod4+q" =
      "exec ${lib.getExe config.programs.qutebrowser.package}";
  };
}
