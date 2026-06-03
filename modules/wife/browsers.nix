{
  flake.modules.homeManager.bow =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
      };

      home.packages = [
        pkgs.chromium
        pkgs.firefox
      ];
    };
}
