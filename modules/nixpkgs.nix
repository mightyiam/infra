{
  lib,
  config,
  inputs,
  ...
}: {
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
  };

  config = {
    flake-file.inputs.nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    perSystem = {
      system,
      pkgs,
      ...
    }: {
      config = {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          inherit (config.nixpkgs) overlays config;
        };

        legacyPackages = pkgs;
      };
    };
  };
}
