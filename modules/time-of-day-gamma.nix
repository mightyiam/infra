{ config, lib, ... }:
{
  flake.modules.homeManager.home =
    homeArgs:
    lib.mkIf homeArgs.config.gui.enable {
      services.wlsunset = {
        enable = true;
        latitude = toString config.location.latitude;
        longitude = toString config.location.longitude;
        temperature.day = 6500;
        temperature.night = 4000;
      };
    };
}
