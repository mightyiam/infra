{ lib, config, ... }:
let
  polyModule =
    args:
    lib.mkIf (!args.hasGlobalPkgs or false) {
      nixpkgs = { inherit (config.nixpkgs) config; };
    };
in
{
  options.nixpkgs.config = {
    allowUnfreePredicate = lib.mkOption {
      type = lib.types.functionTo lib.types.bool;
      default = _: false;
    };
  };

  config.flake = {
    modules = {
      nixos.base = polyModule;
      homeManager.base = polyModule;
    };
  };
}
