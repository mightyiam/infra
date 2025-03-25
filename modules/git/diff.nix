{
  flake.modules.homeManager.base.programs.git = {
    difftastic = {
      enable = true;
      background = "dark";
    };
    extraConfig.diff.algorithm = "histogram";
  };
}
