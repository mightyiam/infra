{
  users.bow = {
    home.gui = hmArgs @ {pkgs, ...}: {
      stylix.fonts = {
        sansSerif = {
          name = "Fredoka";
          package = pkgs.google-fonts;
        };

        serif = hmArgs.config.stylix.fonts.sansSerif;

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
    nixos.pc = nixosArgs: {
      stylix.fonts = {
        inherit
          (nixosArgs.config.home-manager.users.bow.stylix.fonts)
          sansSerif
          serif
          monospace
          emoji
          sizes
          ;
      };
    };
  };
}
