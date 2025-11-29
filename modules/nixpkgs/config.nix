{ lib, config, ... }:
{
  options.nixpkgs.config = {
    allowUnfreePredicate = lib.mkOption {
      type = lib.types.functionTo lib.types.bool;
      default = _: false;
    };
  };

  config.flake = {
    modules = {
      nixos.base.nixpkgs = { inherit (config.nixpkgs) config; };

      homeManager.base = args: {
        nixpkgs = lib.mkIf (!args.hasGlobalPkgs or false) { inherit (config.nixpkgs) config; };
      };
    };
  };
}
