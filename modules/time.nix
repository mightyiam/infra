{
  flake.modules =
    let
      timeZone = "Asia/Bangkok";
    in
    {
      nixos.desktop.services.ntpd-rs.enable = true;
      homeManager.base.home.sessionVariables.TZ = timeZone;
      nixOnDroid.base.time = { inherit timeZone; };
    };
}
