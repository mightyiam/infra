{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
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
          mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
        in
        {
          sway.config.keybindings = {
            "--no-repeat ${mod}+d" = "exec ${rofi} -show drun";
            "${mod}+d" = null;
            "--no-repeat ${mod}+Shift+d" = "exec ${rofi} -show run";
          };

          hyprland.settings.bind = [
            "SUPER, d, exec, ${rofi} -show drun"
            "SUPER+SHIFT, d, exec, ${rofi} -show run"
          ];
        };
    };
}
