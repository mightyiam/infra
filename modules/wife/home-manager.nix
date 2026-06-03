{ config, ... }:
{
  flake.modules.nixos.bow = {
    home-manager.users."1bowapinya" =
      { osConfig, ... }:
      {
        home.stateVersion = osConfig.system.stateVersion;
        imports = [ config.flake.modules.homeManager.bow ];
      };
  };
}
