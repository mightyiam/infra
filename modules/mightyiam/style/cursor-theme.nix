{
  home.gui = {pkgs, ...}: {
    stylix.cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 40;
    };
    home.pointerCursor.enable = true;
  };
}
