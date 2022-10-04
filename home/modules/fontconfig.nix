with builtins;
  instance: {
    pkgs,
    config,
    ...
  }: let
    pipe = pkgs.lib.trivial.pipe;
    monospace = (import ../fonts.nix).monospace;
    aliases = (import ../fonts.nix).aliases;
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
  in {
    fonts.fontconfig.enable = true;
    home.file."${config.xdg.configHome}/fontconfig/fonts.conf" = {
      text = fontsConf {inherit aliases;};
    };
  }
