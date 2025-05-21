{ lib, ... }:
let
  polyModule =
    { pkgs, ... }:
    {
      stylix.cursor = lib.mkDefault {
        package = pkgs.banana-cursor;
        name = "Banana";
        size = 40;
      };
    };

in
{
  flake.modules = {
    nixos.pc = polyModule;
    homeManager.gui = polyModule;
  };
}
