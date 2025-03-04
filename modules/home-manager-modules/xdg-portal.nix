{ config, lib, ... }:
lib.mkIf config.gui.enable {
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
}
