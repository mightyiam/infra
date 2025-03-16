{
  flake.modules =
    let
      timeZone = "Atlantic/Canary";
    in
    {
      nixos.desktop.services.ntpd-rs.enable = true;
      homeManager.base.home.sessionVariables.TZ = timeZone;
      nixOnDroid.base.time = { inherit timeZone; };
    };
}
