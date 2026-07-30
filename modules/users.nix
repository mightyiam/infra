{
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    users = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          userArgs @ {name, ...}: {
            options = {
              username = lib.mkOption {
                type = lib.types.singleLineStr;
                default = name;
              };
              name = lib.mkOption {
                type = lib.types.nullOr lib.types.singleLineStr;
              };
              email = lib.mkOption {
                type = lib.types.nullOr lib.types.singleLineStr;
                default = null;
              };
              nixos = {
                base = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [
                      {
                        users.users.${name} = {
                          name = userArgs.config.username;
                          isNormalUser = true;
                          useDefaultShell = lib.mkDefault true;
                        };
                        home-manager.users.${name} = userArgs.config.home.base;
                      }
                    ];
                  };
                  default = {};
                };
                pc = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [
                      {
                        home-manager.users.${name} = userArgs.config.home.gui;
                      }
                    ];
                  };
                  default = {};
                };
              };
              home = {
                base = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [{home.username = lib.mkDefault userArgs.config.username;}];
                  };
                };
                gui = lib.mkOption {
                  type = lib.types.deferredModule;
                };
              };
            };
            config.home = {inherit (config.homeManager.modules) base gui;};
          }
        )
      );
    };

    home = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };
  };
  config.nixos.modules = lib.mkMerge [
    {
      base = {pkgs, ...}: {
        imports = ["${inputs.home-manager}/nixos"];
        users.defaultUserShell = pkgs.nushell;
      };
    }
  ];
  config.users.mightyiam.home = config.home;
}
