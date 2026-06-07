{
  users.bow.home.gui = polyArgs @ {pkgs, ...}: {
    stylix.fonts = {
      sansSerif = {
        name = "Fredoka";
        package = pkgs.google-fonts;
      };

      serif = polyArgs.config.stylix.fonts.sansSerif;

      monospace = {
        name = "Noto Sans Mono";
        package = pkgs.google-fonts;
      };

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.google-fonts;
      };
    };
  };
}
