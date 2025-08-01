{ config, ... }:
{
  flake.modules.nixos.wife = {
    services.displayManager.autoLogin = {
      enable = true;
      user = config.flake.meta.wife.username;
    };
  };
}
