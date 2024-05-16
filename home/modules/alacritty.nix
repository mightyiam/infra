{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;

  font = (import ../fonts.nix).monospace;
in
  mkIf config.gui.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        live_config_reload = true;
        window.decorations = "none";
        window.dynamic_title = true;
        window.opacity = config.style.windowOpacity;
        window.title = "";
        bell = {
          color = config.style.bellColor;
          duration = builtins.ceil config.style.bellDuration;
        };
        colors = with (import ../gruvbox.nix).colors; {
          primary = {
            background = dark0;
            foreground = light1;
            bright_foreground = light0;
            dim_foreground = light4;
          };
          cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };
          vi_mode_cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };
          selection = {
            text = "CellBackground";
            background = "CellForeground";
          };
          bright = {
            black = gray;
            red = bright_red;
            green = bright_green;
            yellow = bright_yellow;
            blue = bright_blue;
            magenta = bright_purple;
            cyan = bright_aqua;
            white = light1;
          };
          normal = {
            black = dark0;
            red = neutral_red;
            green = neutral_green;
            yellow = neutral_yellow;
            blue = neutral_blue;
            magenta = neutral_purple;
            cyan = neutral_aqua;
            white = light4;
          };
          dim = {
            black = dark0_soft;
            red = faded_red;
            green = faded_green;
            yellow = faded_yellow;
            blue = faded_blue;
            magenta = faded_purple;
            cyan = faded_aqua;
            white = gray;
          };
        };
      };
    };
  }
