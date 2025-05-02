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
    nixos.pc = polyModule;

    homeManager.base =
      { pkgs, ... }:
      {
        imports = [ polyModule ];
        home.packages = [
          pkgs.font-awesome
          pkgs.noto-fonts
          pkgs.gucharmap
        ];
      };

    nixOnDroid.base = polyModule;
  };
}
