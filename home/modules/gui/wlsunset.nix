instance: let
in {
  services.wlsunset = with instance.secrets.location; {
    enable = true;
    latitude = toString latitude;
    longitude = toString longitude;
    temperature.day = 6500;
    temperature.night = 4000;
  };
}
