{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    catppuccin.enable = true;
    package = pkgs.rofi-wayland;
    terminal = config.terminal;
    extraConfig = {
      show-icons = true;
      modi = "run,drun,window";
      combi-modes = [
        "drun"
        "run"
        "window"
      ];
      drun-match-fields = [
        "name"
        "generic"
        "exec"
      ];
      drun-display-format = "{icon} {name}";
      window-display-format = "{icon} {name}";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
    };
    theme = {
      listview.columns = 1;
      "*".font = "monospace ${config.gui.fonts.monospace.size |> builtins.floor |> toString}";
    };
  };
  wayland.windowManager.sway.config.keybindings =
    let
      rofi = lib.getExe config.programs.rofi.package;
      mod = config.wayland.windowManager.sway.config.modifier;
    in
    {
      "--no-repeat ${mod}+p" = "exec ${rofi} -show window";
      "--no-repeat ${mod}+d" = "exec ${rofi} -show drun";
      "${mod}+d" = null;
      "--no-repeat ${mod}+Shift+d" = "exec ${rofi} -show run";
    };
}
