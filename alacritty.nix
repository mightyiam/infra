zshBin: {
  enable = true;
  settings = {
    shell = {
      program = zshBin;
      args = ["--login"];
    };
    background_opacity = 0.8;
    decorations = "none";
    dynamic_title = true;
    font = {
      size = 10.0;
    };
    bell = {
      color = "#000000";
      duration = 200.0;
    };
    live_config_reload = true;
  };
}
