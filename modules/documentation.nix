{
  flake.modules.homeManager.base.programs = {
    tealdeer = {
      enable = true;
      settings.display.use_pager = true;
    };
    info.enable = true;
  };
}
