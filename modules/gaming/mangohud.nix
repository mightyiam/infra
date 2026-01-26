{
  flake.modules.homeManager.gui = {
    programs.mangohud = {
      enable = true;
      settings = {
        gamemode = true;
        gpu_fan = true;
        show_fps_limit = true;
        fps = true;
      };
    };
  };
}
