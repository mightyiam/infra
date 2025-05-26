{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, config, ... }:
    let
      step = 5;
      pactl = lib.getExe' pkgs.pulseaudio "pactl";
      mod = config.wayland.windowManager.sway.config.modifier;

      incVol =
        d:
        lib.concatStringsSep " " [
          pactl
          "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
        ];
    in
    {
      wayland.windowManager = {
        sway.config.keybindings = {
          "--no-repeat ${mod}+x" = "exec ${incVol "-"}";
          "--no-repeat ${mod}+Shift+x" = "exec ${incVol "+"}";
        };
        hyprland.settings.bind = [
          "SUPER, x, exec, ${incVol "-"}"
          "SUPER+SHIFT, x, exec, ${incVol "+"}"
        ];
      };
    };
}
