{
  flake.modules = {
    nixos.pc = {
      services = {
        ntpd-rs.enable = true;
        automatic-timezoned.enable = true;
      };
    };
    nixOnDroid.base = {
      time.timeZone = "Asia/Bangkok";
    };
  };
}
