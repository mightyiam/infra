{
  flake.modules.homeManager.bow =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.libreoffice-fresh ];
    };
}
