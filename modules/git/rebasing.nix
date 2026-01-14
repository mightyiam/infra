{
  flake.modules.homeManager.base = {
    home.packages = [
      #pkgs.git-instafix
    ];
    programs.git.settings.rebase.instructionFormat = "%d %s";
  };
}
