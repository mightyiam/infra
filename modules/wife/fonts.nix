{ lib, ... }:
let
  polyModule =
    polyArgs@{ pkgs, ... }:
    {
      stylix.fonts = lib.mkForce {
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
in
{
  flake.modules = {
    homeManager.wife =
      { pkgs, ... }:
      {
        imports = [ polyModule ];
        fonts.fontconfig.enable = true;
        home.packages = with pkgs; [
          # https://github.com/tlwg/fonts-tlwg
          tlwg
        ];
      };
    nixos.wife = polyModule;
  };
}
