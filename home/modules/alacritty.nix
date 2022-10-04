instance: let
  style = import ../style.nix;
  font = (import ../fonts.nix).monospace;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      decorations = "none";
      dynamic_title = true;
      live_config_reload = true;
      window.opacity = style.windowOpacity;
      bell = {
        color = style.bellColor;
        duration = style.bellDuration;
      };
      colors = with (import ../gruvbox.nix).colors; {
        primary = {
          background = dark1;
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
