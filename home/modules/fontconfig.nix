{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    concatStringsSep
    mkIf
    pipe
    ;

  inherit (import ../fonts.nix) aliases;
  expandPrefer = family: "<family>${family}</family>";
  expandAlias = {
    family,
    prefer,
  }: ''
    <alias>
      <family>${family}</family>
      <prefer>
        ${pipe prefer [(map expandPrefer) (concatStringsSep "\n    ")]}
      </prefer>
    </alias>
  '';
  fontsConf = {aliases}:
    concatStringsSep "\n" [
      ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>''
      (pipe aliases [
        (map expandAlias)
        (concatStringsSep "")
      ])
      ''
        </fontconfig>''
    ];
in
  mkIf config.gui.enable {
    fonts.fontconfig.enable = true;
    home.file."${config.xdg.configHome}/fontconfig/fonts.conf" = {
      text = fontsConf {inherit aliases;};
    };
  }
