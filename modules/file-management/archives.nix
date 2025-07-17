{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.atool
        pkgs.unzip
      ];
    };
}
