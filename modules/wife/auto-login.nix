{ config, lib, ... }:
{
  flake.modules.nixos.wife = {
    services.greetd.settings.initial_session.user = lib.mkForce config.flake.meta.wife.username;
  };
}
