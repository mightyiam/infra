{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;
in
  mkIf config.gui.enable {
    xdg.portal.enable = true;
    xdg.portal.config.common.default = "*";
  }
