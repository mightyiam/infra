# https://github.com/nix-community/stylix/issues/1946
let
  polyModule = {
    stylix.targets.qt.enable = false;
  };
in
{
  flake.modules = {
    homeManager.base = polyModule;
    nixos.pc = polyModule;
  };
}
