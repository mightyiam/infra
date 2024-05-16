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
    gtk.font = {
      name = config.gui.fonts.default.family;
      size = config.gui.fonts.default.size;
    };
  }
