{
  programs.alacritty = {
    enable = true;
    settings = {
      decorations = "none";
      dynamic_title = true;
      live_config_reload = true;
      window.opacity = 0.8;
      bell = {
        color = "#000000";
        duration = 200.0;
      };
    };
  };
}

