{ config, ... }:
{
  flake.modules.nixos.workstation = {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ config.flake.meta.owner.username ];
  };
}
