{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.users.${config.me}.extraGroups = [ "docker" ];
}
