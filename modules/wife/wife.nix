{ config, ... }:
{
  flake = {
    meta.wife.username = "1bowapinya";
    modules.nixos.wife.users.users.${config.flake.meta.wife.username} = {
      isNormalUser = true;
      initialPassword = "";
    };
  };
}
