{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { config, ... }:
    let
      mod = config.wayland.windowManager.sway.config.modifier;
    in
    {
      wayland.windowManager.sway = {
        enable = true;

        config = {

          keybindings = {
            "${mod}+Shift+e" = null;
            "--no-repeat ${mod}+Shift+e" =
              "exec ${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} exit";
          };
        };
      };
    };
}
