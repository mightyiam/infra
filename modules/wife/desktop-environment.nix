{ lib, ... }:
{
  flake.modules.nixos.wife =
    { pkgs, ... }:
    {
      services = {
        system76-scheduler.enable = true;
        desktopManager.cosmic.enable = true;
        greetd.settings.initial_session.command = lib.mkForce (
          lib.getExe' pkgs.cosmic-session "start-cosmic"
        );
      };
    };
}
