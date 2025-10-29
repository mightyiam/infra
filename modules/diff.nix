{
  flake.modules.homeManager.base = {
    programs = {
      difftastic = {
        options.background = "dark";
        enable = true;
        git.enable = true;
      };
      git.settings.diff.algorithm = "histogram";
    };
  };
}
