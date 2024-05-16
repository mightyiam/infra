{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;

  id = "bottom";
in
  mkIf config.gui.enable {
    programs.i3status-rust = {
      enable = true;
      bars = {
        "${id}" = {
          theme = (import ../gruvbox.nix).i3status-rust;
          icons = "awesome5";
          blocks = [
            {
              block = "custom";
              format = "󰪛 ";
              json = true;
              command = ''
                if ${pkgs.gnugrep}/bin/grep -q 1 /sys/class/leds/input*::capslock/brightness; then
                  echo '{ "state": "Warning" }'
                else
                  echo '{}'
                fi
              '';
              watch_files = ["/dev/input"];
              interval = "once";
            }
            {block = "cpu";}
            {block = "memory";}
            {block = "disk_space";}

            #{ block = "docker"; }

            {block = "net";}

            {
              block = "time";
              format = "$icon $timestamp.datetime(f:'%F %a %R')";
            }
            {
              block = "keyboard_layout";
              driver = "sway";
              mappings = {
                "English (US)" = "EN";
                "Hebrew (N/A)" = "HE";
              };
            }
            {block = "sound";}
            {
              block = "sound";
              device_kind = "source";
              format = "$icon ";
            }
            {
              block = "battery";
              missing_format = "";
            }
          ];
        };
      };
    };
    wayland.windowManager.sway.config.bars = [
      {
        mode = "hide";
        statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-${id}.toml";
        trayOutput = "none";
        fonts = {
          names = ["monospace"];
          size = 12.0;
          style = "Bold";
        };
      }
    ];
  }
