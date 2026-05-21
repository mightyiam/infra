{
  lib,
  config,
  inputs,
  ...
}:
{
  options.nixpkgs = {
    config = {
      allowUnfreePredicate = lib.mkOption {
        type = lib.types.functionTo lib.types.bool;
        default = _: false;
      };
      allowUnfreePackages = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [ ];
      };
    };
    overlays = lib.mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [ ];
    };
  };

  config = {
    flake.modules.nixos.base = nixosArgs: {
      nixpkgs = {
        pkgs = import inputs.nixpkgs {
          inherit (nixosArgs.config.hardware.facter.report) system;
          inherit (config.nixpkgs) config overlays;
        };
        hostPlatform = nixosArgs.config.hardware.facter.report.system;
      };
    };
  };
}
