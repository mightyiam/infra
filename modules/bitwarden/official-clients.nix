{
  flake.modules.homeManager = {
    base =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.bitwarden-cli ];
      };

    gui =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.bitwarden-desktop ];
      };
  };
}
