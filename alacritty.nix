{
  programs.alacritty = {
    enable = true;
    settings = {
      decorations = "none";
      dynamic_title = true;
      live_config_reload = true;
      window.opacity = import ./windowOpacity.nix;
      bell = {
        color = "#000000";
        duration = 200.0;
      };
    };
  };
}

