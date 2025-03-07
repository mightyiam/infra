{ config, ... }:
{
  flake.modules.nixos.desktop = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
    users.extraGroups.docker.members = [ config.flake.meta.owner.username ];
  };
}
