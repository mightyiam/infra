let
  polyModule =
    polyArgs@{ pkgs, ... }:
    let
      fontPath = "ofl/fredoka/Fredoka[wdth,wght].ttf";

      google-fonts = pkgs.fetchgit {
        url = "https://github.com/google/fonts.git";
        rev = "54bbd6880add9f874368d5c266790d7af9c94b66";
        sparseCheckout = [ fontPath ];
        hash = "sha256-gEB7BoGGvNtAn/Pk1h4xUQId2DL4XAqK3FptzsrPbGg=";
      };
    in
    {
      stylix.fonts = {
        sansSerif = {
          name = "Fredoka";

          package = pkgs.runCommand "fredoka-font" { } ''
            mkdir -p $out/share/fonts/truetype
            cp "${google-fonts}/${fontPath}" $out/share/fonts/truetype
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
