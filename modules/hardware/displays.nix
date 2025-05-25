{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      dir = "$XDG_CONFIG_HOME/way-displays";
      file = "${dir}/cfg.yaml";
      commands = [
        "${lib.getExe' pkgs.coreutils "mkdir"} -p ${dir}"
        "${lib.getExe' pkgs.coreutils "touch"} ${file}"
        "${lib.getExe pkgs.way-displays} -c ${file} > /tmp/way-displays.$XDG_VTNR.$USER.log 2>&1"
      ];
    in
    {
      wayland.windowManager = {
        sway.config.startup =
          commands
          |> map (command: {
            inherit command;
          });

        hyprland.settings.exec-once = commands;
      };

      home.packages = [ pkgs.way-displays ];
    };
}
