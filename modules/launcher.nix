{ lib, ... }:
{
  flake.modules.homeManager.gui = hmArgs: {
    programs.rofi = {
      enable = true;
      terminal = hmArgs.config.terminal.path;
      extraConfig = {
        show-icons = true;
        modes = [
          "run"
          "drun"
          "window"
        ];
        drun-match-fields = [
          "name"
          "generic"
          "exec"
        ];
        drun-display-format = "{icon} {name}";
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
      };
      theme = {
        listview.columns = 1;
        "*".width = 1200;
      };
    };
    wayland.windowManager =
      let
        rofi = lib.getExe hmArgs.config.programs.rofi.package;
      in
      {
        hyprland.settings.bind = [
          "SUPER, d, exec, ${rofi} -show drun"
          "SUPER+SHIFT, d, exec, ${rofi} -show run"
        ];
      };
  };
}
