{ inputs, ... }:
let
  polyModule =
    polyArgs@{ pkgs, ... }:
    {
      stylix.fonts = {
        sansSerif = {
          name = "Fredoka";

          package = pkgs.runCommand "fredoka-font" { } ''
            mkdir -p $out/share/fonts/truetype
            cp ${inputs.fredoka-font} $out/share/fonts/truetype
          '';
        };

        serif = polyArgs.config.stylix.fonts.sansSerif;
      };
    };
in
{
  flake.modules = {
    homeManager.wife = polyModule;
    nixos.wife = polyModule;
  };
}
