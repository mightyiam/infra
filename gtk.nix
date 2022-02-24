let
  font = (import ./fonts.nix).default;
in {
  gtk.font = {
    name = font.family;
    size = font.size;
  };
}

