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
    polyModule = lib.mkOption {
      readOnly = true;
      type = lib.types.deferredModule;
      default = {
        nixpkgs = cfg.args;
      };
    };
  };

  config = {
    perSystem = {system, ...}: {
      _module.args.pkgs = import inputs.nixpkgs (
        {
          inherit system;
        }
        // cfg.args
      );
    };

    nixos.modules.base = cfg.polyModule;
    homeManager.modules.base = cfg.polyModule;
    armilaria = cfg.polyModule;
  };
}
