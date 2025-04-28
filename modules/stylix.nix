{
  config,
  inputs,
  lib,
  ...
}:
{
  flake.modules = {
    nixos = {
      desktop = {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = {
          enable = true;
          homeManagerIntegration.autoImport = false;
        };
      };

      # Without this import I got
      #
      # > error: The option `home-manager.users."1bowapinya".stylix' does not exist.
      #
      # After reading
      # https://stylix.danth.me/options/platforms/nixos.html#stylixhomemanagerintegrationautoimport
      # https://stylix.danth.me/options/platforms/nixos.html#stylixhomemanagerintegrationfollowsystem
      # I do not understand why.
      wife.home-manager.users.${config.flake.meta.wife.username}.imports = [
        inputs.stylix.homeManagerModules.stylix
      ];
    };

    homeManager.base = {
      imports = [ inputs.stylix.homeManagerModules.stylix ];
      stylix.enable = true;
    };

    nixOnDroid.base = {
      imports = [ inputs.stylix.nixOnDroidModules.stylix ];
      stylix.enable = true;
    };

    nixvim.astrea = nixvimArgs: {
      # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
      imports = lib.optional (nixvimArgs ? homeConfig) nixvimArgs.homeConfig.lib.stylix.nixvim.config;
    };
  };
}
