{ lib, ... }:
{
  flake.modules.homeManager = {
    base =
      { pkgs, ... }:
      {
        options.pinentry = lib.mkOption {
          type = lib.types.package;
        };
        config.pinentry = pkgs.pinentry-curses;
      };
    gui =
      { pkgs, ... }:
      {
        config.pinentry = lib.mkForce pkgs.pinentry-rofi;
      };
  };

}
