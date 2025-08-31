{
  flake.modules = {
    homeManager.wife =
      { pkgs, ... }:
      let
        variant = "-pink";
      in
      {
        stylix.icons = {
          enable = true;
          dark = "Reversal${variant}-dark";
          light = "Reversal${variant}";
          package = pkgs.reversal-icon-theme.override {
            colorVariants = [ variant ];
          };
        };
      };
  };
}
