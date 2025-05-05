{ config, ... }:
{
  flake.modules.nixos.pc.services.getty = {
    autologinOnce = true;
    autologinUser = config.flake.meta.owner.username;
  };
}
