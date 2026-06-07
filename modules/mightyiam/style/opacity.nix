{lib, ...}: {
  home.gui = {
    stylix.opacity = lib.genAttrs [
      "applications"
      "desktop"
      "popups"
      "terminal"
    ] (_: 0.85);
  };
}
