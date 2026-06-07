{
  home.gui = {pkgs, ...}: {
    stylix.fonts = {
      sansSerif = {
        package = pkgs.open-dyslexic;
        name = "OpenDyslexic";
      };

      serif = {
        package = pkgs.open-dyslexic;
        name = "OpenDyslexic";
      };

      monospace = {
        # TODO stop using nerd fonts because they were never a good idea?
        package = pkgs.nerd-fonts.open-dyslexic;
        name = "OpenDyslexicM Nerd Font Mono";
      };

      emoji = {
        package = pkgs.google-fonts;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 12;
      };
    };
  };
}
