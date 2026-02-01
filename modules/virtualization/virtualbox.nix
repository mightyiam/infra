{ config, ... }:
{
  flake.modules.nixos.pc = {
    # https://github.com/NixOS/nixpkgs/issues/449343
    # virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ config.flake.meta.owner.username ];
  };
}
