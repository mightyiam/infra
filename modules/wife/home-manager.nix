{ config, ... }:
{
  flake.modules.nixos.wife = {
    home-manager.users.${config.flake.meta.wife.username} =
      { osConfig, ... }:
      {
        home.stateVersion = osConfig.system.stateVersion;
        imports = [ config.flake.modules.homeManager.wife ];
      };
  };
}
