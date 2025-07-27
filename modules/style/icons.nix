{
  flake.modules = {
    homeManager.gui =
      { pkgs, ... }:
      {
        stylix.icons = {
          enable = true;
          dark = "Papirus-Dark";
          light = "Papirus-Light";
          package = pkgs.papirus-icon-theme;
        };
      };
  };
}
