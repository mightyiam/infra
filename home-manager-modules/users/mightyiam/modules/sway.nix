{
  options,
  pkgs,
  lib,
  config,
  ...
}:
let
  step = 5;
  pactl = pkgs.pulseaudio + /bin/pactl;
  incVol =
    d:
    lib.concatStringsSep " " [
      "exec ${pactl}"
      "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
    ];
  toggleMuteSources = lib.concatStringsSep " " [
    "exec ${pkgs.zsh + /bin/zsh} -c '"
    "for source in $(${pactl} list short sources | ${pkgs.gawk + /bin/awk} \"{print \\$2}\");"
    "do ${pactl} set-source-mute \"$source\" toggle;"
    "done'"
  ];
  mod = config.wayland.windowManager.sway.config.modifier;
in
{
  imports = [
    {
      wayland.windowManager.sway.config.keybindings =
        (options.wayland.windowManager.sway.config.type.getSubOptions { }).keybindings.default;
    }
  ];
  config = lib.mkIf config.gui.enable {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraSessionCommands = ''
        export MOZ_ENABLE_WAYLAND=1
      '';

      config = {
        fonts.size = config.gui.fonts.default.size;

        input = {
          "type:keyboard".xkb_layout = "us,il";
          "type:keyboard".xkb_options = "grp:lalt_lshift_toggle";
          "type:keyboard".repeat_delay = "200";
          "type:keyboard".repeat_rate = "50";
          "type:touchpad".tap = "enabled";
        };

        modifier = "Mod4";

        keybindings = {
          "${mod}+Shift+e" = null;
          "--no-repeat ${mod}+Shift+e" = "exec ${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} exit";
          "--no-repeat ${mod}+x" = incVol "-";
          "--no-repeat ${mod}+Shift+x" = incVol "+";
          "--no-repeat ${mod}+z" = toggleMuteSources;
        };
      };
    };
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
