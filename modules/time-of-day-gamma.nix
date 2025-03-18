{ config, ... }:
{
  flake.modules.homeManager.gui.services.wlsunset = {
    enable = true;
    latitude = toString config.location.latitude;
    longitude = toString config.location.longitude;
    temperature.day = 6500;
    temperature.night = 3000;
  };
}
