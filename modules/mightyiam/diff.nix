{lib, ...}: {
  home.base = hmArgs: {
    programs = {
      difftastic = {
        options.background = "dark";
        enable = true;
        git.enable = true;
      };
      git.settings.diff.algorithm = "histogram";

      lazygit.settings.git.pagers = [
        {
          externalDiffCommand = "${lib.getExe hmArgs.config.programs.difftastic.package}";
        }
        {} # default
      ];
    };
  };
}
