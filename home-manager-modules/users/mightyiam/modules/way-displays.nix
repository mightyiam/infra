{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;

  dir = "$XDG_CONFIG_HOME/way-displays";
  file = "${dir}/cfg.yaml";
  exe = "${lib.getBin way-displays}/bin/way-displays";
  inherit (pkgs) way-displays;
in
mkIf config.gui.enable {
  wayland.windowManager.sway.config.startup = [
    {
      command = "${lib.getBin pkgs.coreutils}/bin/mkdir -p ${dir}";
      always = true;
    }
    {
      command = "${lib.getBin pkgs.coreutils}/bin/touch ${file}";
      always = true;
    }
    {
      command = "${exe} -c ${file} > /tmp/way-displays.$XDG_VTNR.$USER.log 2>&1";
      always = true;
    }
  ];

  home.packages = [ way-displays ];
}
