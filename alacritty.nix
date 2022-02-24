let
  style = import ./style.nix;
  font = (import ./fonts.nix).monospace;
in
{
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
    };
  };
}

