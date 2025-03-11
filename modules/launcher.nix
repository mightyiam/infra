{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      config,
      pkgs,
      ...
    }:
    lib.mkIf config.gui.enable {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        terminal = config.terminal.path;
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
          run-shell-command = config.terminal.withTitle "{cmd}";
        };
        theme = {
          listview.columns = 1;
          "*" = {
            width = 1200;
            font = "monospace ${config.gui.fonts.monospace.size |> builtins.floor |> toString}";
          };
        };
      };
      wayland.windowManager.sway.config.keybindings =
        let
          rofi = lib.getExe config.programs.rofi.package;
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        {
          "--no-repeat ${mod}+d" = "exec ${rofi} -show drun";
          "${mod}+d" = null;
          "--no-repeat ${mod}+Shift+d" = "exec ${rofi} -show run";
          "--no-repeat ${mod}+m" = "exec ${config.secretsMenu}";
        };
    };
}
