{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      wayland.windowManager.sway.config.input."type:keyboard" = {
        xkb_layout = lib.concatStringsSep "," [
          "us"
          "il"
        ];
        xkb_options = "grp:lalt_lshift_toggle";
      };

      programs.i3status-rust.bars.bottom.blocks = lib.mkOrder 1200 [
        {
          block = "keyboard_layout";
          if_command = pkgs.writeShellScript "in-sway" ''
            [ "$XDG_CURRENT_DESKTOP" = "sway" ]
          '';
          driver = "sway";
          mappings = {
            "English (US)" = "EN";
            "Hebrew (N/A)" = "HE";
          };
        }
      ];
    };
}
