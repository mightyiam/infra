{ lib, ... }:
{
  flake.modules = {
    nixos.pc = {
      services = {
        ntpd-rs.enable = true;
        automatic-timezoned.enable = true;

        # https://github.com/NixOS/nixpkgs/issues/68489#issuecomment-1484030107
        geoclue2.enableDemoAgent = lib.mkForce true;
      };
    };
    nixOnDroid.base = {
      time.timeZone = "Asia/Bangkok";
    };
  };
}
