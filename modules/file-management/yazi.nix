{
  flake.modules.homeManager.base = {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };
}
