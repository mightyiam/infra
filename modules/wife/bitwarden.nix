{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.bitwarden ];
    };
}
