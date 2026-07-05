{lib, ...}: {
  home.gui = {pkgs, ...}: let
    step = 5;
    pactl = lib.getExe' pkgs.pulseaudio "pactl";

    incVol = d:
      lib.concatStringsSep " " [
        pactl
        "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
      ];
  in {
    options.audio.deviceNameMaps = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.str;
      default = {};
    };

    config.wayland.windowManager.hyprland.settings.bind = [
      "SUPER, x, exec, ${incVol "-"}"
      "SUPER+SHIFT, x, exec, ${incVol "+"}"
    ];
  };
}
