{
  lib,
  inputs,
  stylix,
  ...
}: {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      flake = false;
    };
    tinted-schemes = {
      flake = false;
      url = "github:tinted-theming/schemes";
    };
  };

  _module.args.stylix = import inputs.stylix;

  nixos.modules.pc = nixosArgs: let
    defaults = nixosArgs.config.home-manager.users.mightyiam.stylix;
  in {
    imports = [stylix.nixosModules.stylix];

    stylix = lib.mkMerge [
      {
        enable = true;
        homeManagerIntegration.autoImport = false;
      }

      (lib.mkDefault {
        inherit (defaults) icons base16Scheme polarity;

        fonts = {
          inherit
            (defaults.fonts)
            sansSerif
            serif
            monospace
            emoji
            sizes
            ;
        };
      })
    ];

    home-manager.sharedModules = [
      {
        stylix.overlays.enable = false;
      }
    ];
  };

  homeManager.modules.base = {
    imports = [stylix.homeModules.stylix];
    stylix.enable = true;
  };
}
