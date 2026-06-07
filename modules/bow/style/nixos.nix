{
  nixos.modules.bow = nixosArgs: let
    stylix = nixosArgs.config.home-manager.users.bow.stylix;
  in {
    stylix = {
      inherit (stylix) icons base16Scheme polarity;

      fonts = {
        inherit
          (stylix.fonts)
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
