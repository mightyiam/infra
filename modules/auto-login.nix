{ config, ... }:
{
  flake.modules.nixos.workstation.services.getty = {
    autologinOnce = true;
    autologinUser = config.flake.meta.owner.username;
  };
}
