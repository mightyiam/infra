{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.file
        pkgs.tokei
      ];
    };
}
