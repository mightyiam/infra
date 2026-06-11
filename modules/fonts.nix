{lib, ...}: {
  homeManager.modules.gui = hmArgs @ {pkgs, ...}: {
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

    config = {
      fonts.fontconfig = {
        enable = true;
        defaultFonts.monospace = [hmArgs.config.fonts.bitmapEmojiFont.name];
      };
      home.packages = [
        hmArgs.config.fonts.bitmapEmojiFont.package
        pkgs.google-fonts
        pkgs.gucharmap
        pkgs.tlwg
        pkgs.uni
      ];
    };
  };
}
