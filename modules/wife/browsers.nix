{
  flake.modules.homeManager.wife =
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
