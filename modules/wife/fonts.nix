let
  polyModule =
    polyArgs@{ pkgs, ... }:
    {
      stylix.fonts = {
        sansSerif = {
          name = "Fredoka";
          package = pkgs.google-fonts;
        };

        serif = polyArgs.config.stylix.fonts.sansSerif;
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
