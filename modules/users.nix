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
                type = lib.types.singleLineStr;
                default = name;
              };
              email = lib.mkOption {
                type = lib.types.nullOr lib.types.singleLineStr;
                default = null;
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
  config = {
    nixos.modules = {
      base = {pkgs, ...}: {
        imports = ["${inputs.home-manager}/nixos"];
        users = {
          defaultUserShell = pkgs.nushell;
          users =
            config.users
            |> lib.mapAttrs (
              _: {username, ...}: {
                name = username;
                isNormalUser = true;
                useDefaultShell = lib.mkDefault true;
              }
            );
        };
        home-manager = {
          users =
            config.users
            |> lib.mapAttrs (
              _: {home, ...}: {
                imports = [
                  home.base
                ];
              }
            );
        };
      };

      pc = {
        home-manager.users =
          config.users
          |> lib.mapAttrs (_: {home, ...}: home.gui);
      };
    };

    users.mightyiam.home = config.home;
  };
}
