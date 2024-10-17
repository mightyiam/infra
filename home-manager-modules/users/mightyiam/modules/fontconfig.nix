{ config, lib, ... }:
let
  inherit (lib) concatStringsSep mkIf;

  expandPrefer = family: "<family>${family}</family>";
  expandAlias =
    { family, prefer }:
    ''
      <alias>
        <family>${family}</family>
        <prefer>
          ${map expandPrefer prefer |> concatStringsSep "\n    "}
        </prefer>
      </alias>
    '';
  fontsConf =
    { aliases }:
    concatStringsSep "\n" [
      ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>''
      (map expandAlias aliases |> concatStringsSep "")
      ''</fontconfig>''
    ];
in
mkIf config.gui.enable {
  fonts.fontconfig.enable = true;
  home.file."${config.xdg.configHome}/fontconfig/fonts.conf" = {
    text = fontsConf { inherit (config.gui.fonts) aliases; };
  };
}
