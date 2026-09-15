{
  inputs,
  lib,
  ...
}: {
  options.homeManager = {
    modules = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
        apply = module: {
          key = "base";
          imports = [module];
        };
      };
      gui = lib.mkOption {
        type = lib.types.deferredModule;
        apply = module: {
          key = "gui";
          imports = [module];
        };
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
