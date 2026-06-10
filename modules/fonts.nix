{lib, ...}: let
  polyModule = polyArgs @ {pkgs, ...}: {
    options.fonts.bitmapEmojiFont = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.twitter-color-emoji;
      };
      name = lib.mkOption {
        type = lib.types.str;
        default = "Twitter Color Emoji";
      };
    };
    config.fonts.fontconfig = {
      enable = true;
      defaultFonts.monospace = [polyArgs.config.fonts.bitmapEmojiFont.name];
    };
  };
in {
  nixos.modules.pc = nixosArgs @ {pkgs, ...}: {
    imports = [polyModule];
    fonts.packages = [
      nixosArgs.config.fonts.bitmapEmojiFont.package
      pkgs.google-fonts
      pkgs.gucharmap
      pkgs.tlwg
      pkgs.uni
    ];
  };

  homeManager.modules.gui = hmArgs: {
    imports = [polyModule];
    home.packages = [hmArgs.config.fonts.bitmapEmojiFont.package];
    fonts.fontconfig.defaultFonts.monospace = [hmArgs.config.fonts.bitmapEmojiFont.name];
  };
}
