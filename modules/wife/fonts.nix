{ withSystem, ... }:
let
  polyModule =
    polyArgs@{ pkgs, ... }:
    {
      stylix.fonts = {
        sansSerif = {
          name = "Fredoka";
          package = withSystem pkgs.system (psArgs: psArgs.config.packages.fredoka-font);
        };

        serif = polyArgs.config.stylix.fonts.sansSerif;
      };
    };
in
{
  perSystem =
    { pkgs, ... }:
    let
      fontPath = "ofl/fredoka/Fredoka[wdth,wght].ttf";

      google-fonts-sparse = pkgs.fetchgit {
        url = "https://github.com/google/fonts.git";
        rev = "54bbd6880add9f874368d5c266790d7af9c94b66";
        sparseCheckout = [ fontPath ];
        hash = "sha256-gEB7BoGGvNtAn/Pk1h4xUQId2DL4XAqK3FptzsrPbGg=";
      };
    in
    {
      packages.fredoka-font = pkgs.runCommand "fredoka-font" { } ''
        mkdir -p $out/share/fonts/truetype
        cp "${google-fonts-sparse}/${fontPath}" $out/share/fonts/truetype
      '';
    };

  flake.modules = {
    homeManager.wife =
      { pkgs, ... }:
      {
        imports = [ polyModule ];
        fonts.fontconfig.enable = true;
        home.packages = with pkgs; [
          # https://fonts.google.com/specimen/Chonburi
          chonburi-font
          # https://fonts.google.com/specimen/Kanit
          kanit-font
          # https://fonts.google.com/specimen/Sarabun
          sarabun-font
          # https://github.com/tlwg/fonts-tlwg
          tlwg
        ];
      };
    nixos.wife = polyModule;
  };
}
