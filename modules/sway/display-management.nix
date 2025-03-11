{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      pkgs,
      config,
      ...
    }:
    let
      dir = "$XDG_CONFIG_HOME/way-displays";
      file = "${dir}/cfg.yaml";
    in
    lib.mkIf config.gui.enable {
      wayland.windowManager.sway.config.startup = map (command: { inherit command; }) [
        "${lib.getExe' pkgs.coreutils "mkdir"} -p ${dir}"
        "${lib.getExe' pkgs.coreutils "touch"} ${file}"
        "${lib.getExe pkgs.way-displays} -c ${file} > /tmp/way-displays.$XDG_VTNR.$USER.log 2>&1"
      ];

      home.packages = [ pkgs.way-displays ];
    };
}
