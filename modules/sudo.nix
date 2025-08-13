{ config, ... }:
{
  flake.modules.nixos.base = {
    security.sudo-rs.enable = true;
    users.users.${config.flake.meta.owner.username}.extraGroups = [
      "wheel"
      "systemd-journal"
    ];
  };
}
