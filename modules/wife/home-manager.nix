{ config, ... }:
{
  flake.modules.nixos.bow = {
    home-manager.users.${config.flake.meta.bow.username} =
      { osConfig, ... }:
      {
        home.stateVersion = osConfig.system.stateVersion;
        imports = [ config.flake.modules.homeManager.bow ];
      };
  };
}
