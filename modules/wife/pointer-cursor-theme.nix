{ lib, ... }:
let
  polyModule =
    { pkgs, ... }:
    {
      stylix.cursor = {
        package = pkgs.catppuccin-cursors.frappePink;
        name = "catppuccin-frappe-pink-cursors";
        size = 32;
      };
    };

in
{
  flake.modules = {
    nixos.wife = polyModule;
    homeManager.wife = polyModule;
  };
}
