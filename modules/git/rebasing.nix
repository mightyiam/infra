{
  flake.modules.homeManager.base = {
    home.packages = [
      # https://github.com/quodlibetor/git-instafix/issues/39
      # pkgs.git-instafix
    ];
    programs.git.extraConfig.rebase.instructionFormat = "%d %s";
  };
}
