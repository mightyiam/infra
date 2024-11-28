{
  config,
  lib,
  pkgs,
  ...
}:
let
  id = "bottom";
in
lib.mkIf config.gui.enable {
  programs.i3status-rust = {
    enable = true;
    bars = {
      "${id}" = {
        icons = "awesome5";
        blocks = [
          {
            block = "sound";
            format = " $output_description $icon {$volume.eng(w:2) |}";
          }
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
            watch_files = [ "/dev/input" ];
            interval = "once";
          }
          { block = "cpu"; }
          { block = "memory"; }
          { block = "disk_space"; }

          #{ block = "docker"; }

          { block = "net"; }

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
      statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-${id}.toml";
      trayOutput = "none";
      fonts = {
        names = [ "monospace" ];
        size = 12.0;
        style = "Bold";
      };
    }
  ];
}
