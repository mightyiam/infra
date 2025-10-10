{
  flake.modules.homeManager.base.programs.git = {
    difftastic = {
      enable = true;
      options.background = "dark";
    };
    extraConfig.diff.algorithm = "histogram";
  };
}
