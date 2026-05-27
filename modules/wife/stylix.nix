{ stylix, ... }:
{
  flake.modules = {
    homeManager.wife = {
      imports = [ stylix.homeModules.stylix ];
      stylix.enable = true;
    };
  };
}
