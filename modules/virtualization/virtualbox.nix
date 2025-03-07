{ config, ... }:
{
  flake.modules.nixos.virtualbox = {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ config.flake.meta.owner.username ];
  };
}
