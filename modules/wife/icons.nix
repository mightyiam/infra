{
  flake.modules = {
    homeManager.wife =
      { pkgs, ... }:
      {
        stylix.icons = {
          enable = true;
          dark = "Reversal-dark";
          light = "Reversal";
          package = pkgs.reversal-icon-theme;
        };
      };
  };
}
