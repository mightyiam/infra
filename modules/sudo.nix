{ config, ... }:
{
  flake.modules.nixos.pc = {
    security.sudo-rs.enable = true;
    users.users.${config.flake.meta.owner.username}.extraGroups = [ "wheel" ];
  };
}
