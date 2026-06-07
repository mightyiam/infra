{
  home.gui = {pkgs, ...}: {
    stylix.cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 40;
    };
  };
}
