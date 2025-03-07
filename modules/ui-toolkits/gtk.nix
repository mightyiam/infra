{ lib, ... }:
{
  flake.modules.homeManager.home =
    { config, ... }:
    lib.mkIf config.gui.enable {
      gtk.enable = true;
    };
}
