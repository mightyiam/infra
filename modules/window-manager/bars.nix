{ lib, withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.i3status-capslock-util = pkgs.writers.writeNuBin "i3status-capslock-util" ''
        def main [] {
          let brightness = (glob --follow-symlinks '/sys/class/leds/input*\:\:*capslock/brightness' | first | open | into int)
          if $brightness == 1 {
            print '{ "state": "Warning" }'
          } else {
            print '{ "state": "Idle" }'
          }
        }
      '';
    };
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      id = "bottom";
      capslockSignal = 11;
    in
    {
      programs.i3status-rust = {
        enable = true;
        bars = {
          "${id}" = {
            icons = "material-nf";
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
                  command =
                    withSystem pkgs.stdenv.system (psArgs: psArgs.config.packages.i3status-capslock-util) |> lib.getExe;
                  signal = capslockSignal;
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

      wayland = {
        windowManager = {
          hyprland = {
            settings =
              let
                binding = ", Caps_Lock, exec, pkill -SIGRTMIN+${toString capslockSignal} i3status-rs";
              in
              {
                bindr = [ binding ];
                exec-once = [
                  (lib.getExe hmArgs.config.programs.i3bar-river.package)
                ];
              };
          };
        };
      };

      programs.i3bar-river = {
        enable = true;

        settings = {
          blend = false;
          command =
            [
              (lib.getExe hmArgs.config.programs.i3status-rust.package)
              "${hmArgs.config.xdg.configHome}/i3status-rust/config-${id}.toml"
            ]
            |> lib.concatStringsSep " ";
          position = "bottom";
        };
      };
    };
}
