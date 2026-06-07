{
  users.bow.home.gui = {pkgs, ...}: {
    stylix.cursor = {
      package = pkgs.catppuccin-cursors.frappePink;
      name = "catppuccin-frappe-pink-cursors";
      size = 32;
    };
  };
}
