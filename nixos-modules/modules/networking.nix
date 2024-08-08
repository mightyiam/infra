{ config, ... }:
{
  networking.networkmanager.enable = true;
  users.users.${config.me}.extraGroups = [ "networkmanager" ];
}
