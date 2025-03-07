{ lib, config, ... }:
{
  options.nixpkgs.allowUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config.flake.modules =
    let
      predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowUnfreePackages;
    in
    {
      nixos.desktop.nixpkgs.config.allowUnfreePredicate = predicate;

      homeManager.home = args: {
        nixpkgs.config = lib.mkIf (!(args.hasGlobalPkgs or false)) {
          allowUnfreePredicate = predicate;
        };
      };
    };
}
