{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      config,
      pkgs,
      ...
    }:
    {
      options.pinentry = lib.mkOption {
        type = lib.types.package;
      };
      config.pinentry = if config.gui.enable then pkgs.pinentry-rofi else pkgs.pinentry-curses;
    };
}
