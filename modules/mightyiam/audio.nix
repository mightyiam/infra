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
    options.audio.sinkNameMap = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.str;
      default = {};
    };

    config.wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + x"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${incVol "-"}")'')
        ];
      }
      {
        _args = [
          "SUPER + SHIFT + x"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${incVol "+"}")'')
        ];
      }
    ];
  };
}
