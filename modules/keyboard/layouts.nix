{ lib, config, ... }:
{
  flake.modules.homeManager.gui = {
    wayland.windowManager.sway.config.input."type:keyboard".xkb_layout = lib.concatStringsSep "," [
      "us"
      "il"
    ];

    programs.i3status-rust.bars.bottom.blocks = lib.mkOrder 1200 [
      {
        block = "keyboard_layout";
        driver = "sway";
        mappings = {
          "English (US)" = "EN";
          "Hebrew (N/A)" = "HE";
        };
      }
    ];
  };
}
