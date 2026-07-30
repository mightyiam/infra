{
  inputs,
  lib,
  ...
}: {
  options.homeManager = {
    modules = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
      };
      gui = lib.mkOption {
        type = lib.types.deferredModule;
      };
    };
  };

  config = {
    flake-file.inputs.home-manager = {
      url = "github:nix-community/home-manager";
      flake = false;
    };

    _module.args.homeManager = import "${inputs.home-manager}/lib" {inherit lib;};

    homeManager.modules.base = {
      programs.home-manager.enable = true;
    };

    nixos.modules.base = {pkgs, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        sharedModules = [
          ({osConfig, ...}: {
            home = {
              stateVersion = osConfig.system.stateVersion;
            };
            stylix.overlays.enable = false;
          })
        ];
        backupCommand = lib.getExe' pkgs.trash-cli "trash-put";
      };
    };
  };
}
