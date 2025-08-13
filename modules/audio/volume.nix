{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      step = 5;
      pactl = lib.getExe' pkgs.pulseaudio "pactl";

      incVol =
        d:
        lib.concatStringsSep " " [
          pactl
          "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
        ];
    in
    {
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER, x, exec, ${incVol "-"}"
        "SUPER+SHIFT, x, exec, ${incVol "+"}"
      ];
    };
}
