{ inputs, ... }:
let
  polyModule = {
    stylix.enable = true;
  };
in
{
  flake.modules = {
    nixos.wife = polyModule;
    homeManager.wife = {
      imports = [
        inputs.stylix.homeModules.stylix
        polyModule
      ];
    };
  };
}
