{ config, ... }:
{
  flake = {
    meta.bow.username = "1bowapinya";
    modules.nixos.bow = {
      users.users.${config.flake.meta.bow.username} = {
        isNormalUser = true;
        initialPassword = "";
        extraGroups = [ "lpadmin" ];
      };
    };
  };
}
