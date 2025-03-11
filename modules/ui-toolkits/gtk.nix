{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    lib.mkIf config.gui.enable {
      gtk.enable = true;
    };
}
