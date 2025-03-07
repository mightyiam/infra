{ lib, ... }:
{
  flake.modules.homeManager.home =
    { config, ... }:
    lib.mkIf config.gui.enable {
      xdg.portal.enable = true;
      xdg.portal.config.common.default = "*";
    };
}
