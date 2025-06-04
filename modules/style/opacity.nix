{ lib, ... }:
let
  polyModule = {
    stylix.opacity = lib.genAttrs [ "applications" "desktop" "popups" "terminal" ] (n: 0.9);
  };
in
{
  flake.modules = {
    nixos.pc = polyModule;
    homeManager.gui = polyModule;
    nixOnDroid.base = polyModule;
  };
}
