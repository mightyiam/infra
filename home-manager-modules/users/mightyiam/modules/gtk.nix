{ config, lib, ... }:
lib.mkIf config.gui.enable {
  gtk.enable = true;
  gtk.font = {
    name = config.gui.fonts.default.family;
    size = config.gui.fonts.default.size;
  };
}
