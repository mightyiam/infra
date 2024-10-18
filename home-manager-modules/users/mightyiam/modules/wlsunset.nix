{ config, lib, ... }:
lib.mkIf config.gui.enable {
  services.wlsunset = with config.location; {
    enable = true;
    latitude = toString latitude;
    longitude = toString longitude;
    temperature.day = 6500;
    temperature.night = 4000;
  };
}
