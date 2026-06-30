{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.nixpkgs;
in {
  options.nixpkgs = {
    config = {
      allowUnfreePredicate = lib.mkOption {
        type = lib.types.functionTo lib.types.bool;
        default = _: false;
      };
      allowUnfreePackages = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [];
      };
    };
    overlays = lib.mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [];
    };
    args = lib.mkOption {
      type = lib.types.unspecified;
      default = {
        inherit (cfg) overlays;
        config = {inherit (cfg.config) allowUnfreePredicate allowUnfreePackages;};
      };
    };
  };

  config = {
    flake-file.inputs.nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    perSystem = {
      system,
      pkgs,
      ...
    }: {
      _module.args.pkgs = import inputs.nixpkgs (
        {
          inherit system;
        }
        // cfg.args
      );

      legacyPackages = pkgs;
    };
  };
}
