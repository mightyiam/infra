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

      wayland.windowManager.sway.config.bars = [
        {
          statusCommand = "i3status-rs ${hmArgs.config.xdg.configHome}/i3status-rust/config-${id}.toml";
          trayOutput = "none";
          fonts = {
            names = [ hmArgs.config.stylix.fonts.monospace.name ];
            size = hmArgs.config.stylix.fonts.sizes.desktop / 1.0;
            style = "Bold";
          };
        }
      ];
    };
}
