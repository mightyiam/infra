{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config.flake = {
    modules =
      let
        predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
      in
      {
        nixos.desktop.nixpkgs.config.allowedUnfreePredicate = predicate;

        homeManager.base = args: {
          nixpkgs.config = lib.mkIf (!(args.hasGlobalPkgs or false)) {
            allowedUnfreePredicate = predicate;
          };
        };
      };

    meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
  };

}
