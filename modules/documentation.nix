{
  flake.modules.homeManager.home.programs = {
    tealdeer = {
      enable = true;
      settings.display.use_pager = true;
    };
    info.enable = true;
  };
}
