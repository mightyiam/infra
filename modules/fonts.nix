{ lib, ... }:
let
  polyModule =
    polyArgs@{ pkgs, ... }:
    {
      stylix.fonts = {
        sansSerif = lib.mkDefault {
          package = pkgs.open-dyslexic;
          name = "OpenDyslexic";
        };

        serif = lib.mkDefault polyArgs.config.stylix.fonts.sansSerif;

        monospace = {
          package = pkgs.nerd-fonts.open-dyslexic;
          name = "OpenDyslexicM Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
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
in
{
  flake.modules = {
    nixos.pc =
      { pkgs, ... }:
      {
        imports = [ polyModule ];
        fonts.packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
        ];
      };

    homeManager.gui =
      { pkgs, ... }:
      {
        imports = [ polyModule ];
        home.packages = [
          pkgs.gucharmap
        ];
      };

    nixOnDroid.base = polyModule;
  };
}
