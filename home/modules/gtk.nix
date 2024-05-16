{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;

  font = (import ../fonts.nix).default;
in
  mkIf config.gui.enable {
    gtk.font = {
      name = font.family;
      inherit (font) size;
    };
  }
