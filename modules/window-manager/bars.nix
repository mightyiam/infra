{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      id = "bottom";
    in
    {
      programs.i3status-rust = {
        enable = true;
        bars = {
          "${id}" = {
            icons = "awesome5";
            settings.theme.overrides = hmArgs.config.lib.stylix.i3status-rust.bar;
            blocks = lib.mkMerge [
              [
                {
                  block = "sound";
                  device_kind = "source";
                }
                {
                  block = "sound";
                  format = " $output_description $icon {$volume.eng(w:2)|} ";
                }
                { block = "cpu"; }
                { block = "memory"; }
                { block = "disk_space"; }

                #{ block = "docker"; }

                { block = "net"; }

                {
                  block = "time";
                  format = " $timestamp.datetime(f:'%F %a %R') ";
                }
                {
                  block = "custom";
                  format = " 󰪛 ";
                  json = true;
                  command = ''
                    if ${pkgs.gnugrep}/bin/grep -q 1 /sys/class/leds/input*::capslock/brightness; then
                      echo '{ "state": "Warning" }'
                    else
                      echo '{}'
                    fi
                  '';
                  watch_files = [ "/dev/input" ];
                  interval = "once";
                }
              ]
              (lib.mkOrder 1300 [
                {
                  block = "battery";
                  missing_format = "";
                }
              ])
            ];
          };
        };
      };

      home.packages = [ pkgs.font-awesome ];

      wayland.windowManager = {
        sway.config = {
          bars = [
            {
              extraConfig = ''
                mode overlay
              '';
              colors = hmArgs.config.lib.stylix.i3.bar.colors // {
                background = "#00000000";
              };
              trayOutput = "none";
            }
          ];

          startup = [
            { command = lib.getExe hmArgs.config.programs.i3bar-river.package; }
          ];
        };

        hyprland.settings.exec-once = [
          (lib.getExe hmArgs.config.programs.i3bar-river.package)
        ];
      };

      programs.i3bar-river = {
        enable = true;

        settings = {
          command =
            [
              (lib.getExe hmArgs.config.programs.i3status-rust.package)
              "${hmArgs.config.xdg.configHome}/i3status-rust/config-${id}.toml"
            ]
            |> lib.concatStringsSep " ";
          position = "bottom";

          # on sway this matches the swaybar that is overlayed on top of it
          height = 36;
        };
      };
    };
}
