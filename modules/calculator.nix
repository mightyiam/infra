{
  flake.modules.homeManager = {
    base =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.bc ];
      };
    gui =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.qalculate-gtk ];
      };
  };
}
