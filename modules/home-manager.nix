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
          config.flake.modules.homeManager.base
          config.flake.modules.homeManager.gui
        ];
      };
    };

    homeManager.base = args: {
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
          imports = [ config.flake.modules.homeManager.base ];
        };
      };
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      checks =
        {
          base = with config.flake.modules.homeManager; [ base ];
          gui = with config.flake.modules.homeManager; [
            base
            gui
          ];
        }
        |> lib.mapAttrs' (
          name: modules: {
            name = "homeManagerConfigurations/${name}";
            value =
              {
                inherit pkgs;
                modules = modules ++ [ { home.stateVersion = "25.05"; } ];
              }
              |> inputs.home-manager.lib.homeManagerConfiguration
              |> lib.getAttrFromPath [
                "config"
                "home-files"
              ];
          }
        );
    };
}
