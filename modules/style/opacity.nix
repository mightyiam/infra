{ lib, ... }:
let
  polyModule = {
    stylix.opacity = lib.genAttrs [ "applications" "desktop" "popups" "terminal" ] (n: 0.85);
  };
in
{
  flake.modules = {
    nixos.pc = polyModule;
    homeManager.gui = polyModule;
    nixOnDroid.base = polyModule;
  };
}
