{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.git-instafix
      ];
      programs.git.settings.rebase.instructionFormat = "%d %s";
    };
}
