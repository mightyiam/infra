{ config, ... }:
{
  flake.modules.nixos.workstation = {
    # https://github.com/NixOS/nixpkgs/issues/449343
    # virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ config.flake.meta.owner.username ];
  };
}
