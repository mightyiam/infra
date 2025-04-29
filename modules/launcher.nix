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
          run-shell-command = hmArgs.config.terminal.withTitle "{cmd}";
        };
        theme = {
          listview.columns = 1;
          "*".width = 1200;
        };
      };
      wayland.windowManager.sway.config.keybindings =
        let
          rofi = lib.getExe hmArgs.config.programs.rofi.package;
          mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
        in
        {
          "--no-repeat ${mod}+d" = "exec ${rofi} -show drun";
          "${mod}+d" = null;
          "--no-repeat ${mod}+Shift+d" = "exec ${rofi} -show run";
        };
    };
}
