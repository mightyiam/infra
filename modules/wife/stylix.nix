{ inputs, ... }:
{
  flake.modules = {
    homeManager.wife = {
      imports = [ inputs.stylix.homeModules.stylix ];
      stylix = {
        enable = true;
        enableReleaseChecks = false;
      };
    };
  };
}
