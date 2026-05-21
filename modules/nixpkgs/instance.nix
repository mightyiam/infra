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
    factory = lib.mkOption {
      type = lib.types.functionTo lib.types.pkgs;
      readOnly = true;
      default =
        system:
        import inputs.nixpkgs {
          inherit system;
          inherit (config.nixpkgs) config overlays;
        };
    };
  };

  config = {
    flake.modules.nixos.base = nixosArgs: {
      nixpkgs = {
        pkgs = config.nixpkgs.factory nixosArgs.config.hardware.facter.report.system;
        hostPlatform = nixosArgs.config.hardware.facter.report.system;
      };
    };
  };
}
