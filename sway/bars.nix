{ config, ... }:
let
  id = "bottom";
  outputs = import ../outputs.nix;
  font = (import ../fonts.nix).bars;
  secrets = import ../secrets.nix;
in
{
  wayland.windowManager.sway.extraSessionCommands = ''
    export I3RS_GITHUB_TOKEN=${secrets.I3RS_GITHUB_TOKEN}
  '';
  programs.i3status-rust = {
    enable = true;
    bars = {
      "${id}" = {
        theme = (import ../gruvbox.nix).i3status-rust;
        icons = "awesome5";
        blocks = [
          { block = "cpu"; }
          { block = "memory"; }
          { block = "disk_space"; }
          #{ block = "nvidia_gpu"; }

          { block = "docker"; }
          { block = "github"; }

          { block = "net"; }
          { block = "networkmanager"; device_format = "{icon}{ap}"; }

          { block = "time"; format = "%F %a %R"; }
          {
            block = "keyboard_layout";
            driver = "sway";
            mappings = {
              "English (US)" = "EN";
              "Hebrew (N/A)" = "HE";
            };
          }
          { block = "sound"; }
        ];
      };
    };
  };
  wayland.windowManager.sway.config.bars = [
    {
      statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-${id}.toml";
      trayOutput = outputs.left.path;
      fonts = {
        names = [ font.family ];
        style = font.style;
        size = font.size;
      };
    }
  ];
}
