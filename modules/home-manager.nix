{
  config,
  lib,
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.desktop = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs.hasGlobalPkgs = true;

        users.${config.flake.meta.owner.username}.imports = [
          (
            { osConfig, ... }:
            {
              home.stateVersion = osConfig.system.stateVersion;
            }
          )
          config.flake.modules.homeManager.home
        ];
      };
    };

    homeManager.home = args: {
      home = lib.mkIf (!(args.hasDifferentUsername or false)) {
        username = config.flake.meta.owner.username;
        homeDirectory = "/home/${config.flake.meta.owner.username}";
      };
      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
    };

    nixOnDroid.base = args: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          hasGlobalPkgs = true;
          hasDifferentUsername = true;
        };
        config = {
          home.stateVersion = args.config.system.stateVersion;
          gui.enable = false;
          imports = [ config.flake.modules.homeManager.home ];
        };
      };
    };
  };
}
