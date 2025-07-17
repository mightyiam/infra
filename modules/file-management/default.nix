{
  flake.modules.homeManager.base = {
    programs.yazi = {
      enable = true;
      settings = {
        mgr.show_hidden = true;
      };
    };
  };
}
