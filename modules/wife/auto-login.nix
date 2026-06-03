{ config, lib, ... }:
{
  flake.modules.nixos.bow = {
    services.greetd.settings.initial_session.user = lib.mkForce config.flake.meta.bow.username;
  };
}
