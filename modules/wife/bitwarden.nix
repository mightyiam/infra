{
  flake.modules.homeManager.bow =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.bitwarden-desktop ];
    };
}
