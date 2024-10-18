{ config, lib, ... }:
let
  expandPrefer = family: "<family>${family}</family>";
  expandAlias =
    { family, prefer }:
    ''
      <alias>
        <family>${family}</family>
        <prefer>
          ${map expandPrefer prefer |> lib.concatStringsSep "\n    "}
        </prefer>
      </alias>
    '';
  fontsConf =
    { aliases }:
    lib.concatStringsSep "\n" [
      ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>''
      (map expandAlias aliases |> lib.concatStringsSep "")
      ''</fontconfig>''
    ];
in
lib.mkIf config.gui.enable {
  fonts.fontconfig.enable = true;
  home.file."${config.xdg.configHome}/fontconfig/fonts.conf" = {
    text = fontsConf { inherit (config.gui.fonts) aliases; };
  };
}
