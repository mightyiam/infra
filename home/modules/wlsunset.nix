let
  location = (import ../secrets.nix).location;
in {
  services.wlsunset = with location; {
    enable = true;
    latitude = toString latitude;
    longitude = toString longitude;
    temperature.day = 6500;
    temperature.night = 4000;
  };
}
