{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.libreoffice-fresh ];
    };
}
