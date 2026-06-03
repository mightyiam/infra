{ lib, ... }:
{
  flake.modules.nixos.bow = {
    services.greetd.settings.initial_session.user = lib.mkForce "1bowapinya";
  };
}
