{
  mkModuleOption,
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
                base = mkModuleOption {
                  key = "${name}-base";
                  static = {
                    users.users.${name} = {
                      name = userArgs.config.username;
                      isNormalUser = true;
                      useDefaultShell = lib.mkDefault true;
                      initialPassword = "america";
                    };
                    home-manager.users.${name} = userArgs.config.home.base;
                  };
                };
                pc = mkModuleOption {
                  key = "${name}-pc";
                  static = {
                    imports = [userArgs.config.nixos.base];
                    home-manager.users.${name} = userArgs.config.home.gui;
                  };
                };
              };
              home = {
                base = mkModuleOption {
                  key = "${name}-base";
                  static = {
                    imports = [config.homeManager.modules.base];
                    home.username = lib.mkDefault userArgs.config.username;
                  };
                };
                gui = mkModuleOption {
                  key = "${name}-gui";
                  static = {
                    imports = [
                      userArgs.config.home.base
                      config.homeManager.modules.gui
                    ];
                  };
                };
              };
            };
          }
        )
      );
    };
  };
  config.nixos.modules.base = {pkgs, ...}: {
    imports = ["${inputs.home-manager}/nixos"];
    users.defaultUserShell = pkgs.nushell;
  };
}
