{
  home.gui = hmArgs @ {pkgs, ...}: let
    cfg = hmArgs.config.stylix.fonts;
  in {
    stylix.fonts = {
      sansSerif = cfg.monospace;
      serif = cfg.monospace;

      monospace = {
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
