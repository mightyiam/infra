{
  flake.modules.homeManager.gui =
    {
      config,
      pkgs,
      ...
    }:
    let
      id = "bottom";
    in
    {
      programs.i3status-rust = {
        enable = true;
        bars = {
          "${id}" = {
            icons = "awesome5";
            blocks = [
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
              {
                block = "keyboard_layout";
                driver = "sway";
                mappings = {
                  "English (US)" = "EN";
                  "Hebrew (N/A)" = "HE";
                };
              }
              {
                block = "battery";
                missing_format = "";
              }
            ];
          };
        };
      };

      home.packages = [ pkgs.font-awesome ];

      wayland.windowManager.sway.config.bars = [
        {
          statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-${id}.toml";
          trayOutput = "none";
          fonts = {
            names = [ config.stylix.fonts.monospace.name ];
            size = config.stylix.fonts.sizes.desktop / 1.0;
            style = "Bold";
          };
        }
      ];
    };
}
