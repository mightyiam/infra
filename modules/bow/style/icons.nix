{
  users.bow = {
    home.gui = {pkgs, ...}: let
      variant = "pink";
    in {
      stylix.icons = {
        enable = true;
        dark = "Reversal-${variant}-dark";
        light = "Reversal-${variant}";
        package = pkgs.reversal-icon-theme.override {
          colorVariants = [variant];
        };
      };
    };
    nixos.pc = nixosArgs: {
      stylix = {
        inherit (nixosArgs.config.home-manager.users.bow.stylix) icons;
      };
    };
  };
}
