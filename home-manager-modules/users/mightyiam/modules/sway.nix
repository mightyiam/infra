{
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
  swayMsgPath = config.wayland.windowManager.sway.package + /bin/swaymsg;
in
{
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

        terminal = "false";
        modifier = "Mod4";

        keybindings = {
          ${config.keyboard.wm.kill} = "kill";
          ${config.keyboard.wm.menu} = "exec ${config.wayland.windowManager.sway.config.menu}";

          ${config.keyboard.wm.focus.left} = "focus left";
          ${config.keyboard.wm.focus.down} = "focus down";
          ${config.keyboard.wm.focus.up} = "focus up";
          ${config.keyboard.wm.focus.right} = "focus right";
          ${config.keyboard.wm.focus.parent} = "focus parent";

          ${config.keyboard.wm.move.left} = "move left";
          ${config.keyboard.wm.move.down} = "move down";
          ${config.keyboard.wm.move.up} = "move up";
          ${config.keyboard.wm.move.right} = "move right";

          ${config.keyboard.wm.fullscreen} = "fullscreen toggle";

          ${config.keyboard.wm.layout.tabbed} = "layout tabbed";
          ${config.keyboard.wm.layout.toggleSplit} = "layout toggle split";

          ${config.keyboard.wm.floatingToggle} = "floating toggle";
          ${config.keyboard.wm.focusModeToggle} = "focus mode_toggle";

          ${config.keyboard.wm.workspace."1"} = "workspace number 1";
          ${config.keyboard.wm.workspace."2"} = "workspace number 2";
          ${config.keyboard.wm.workspace."3"} = "workspace number 3";
          ${config.keyboard.wm.workspace."4"} = "workspace number 4";
          ${config.keyboard.wm.workspace."5"} = "workspace number 5";
          ${config.keyboard.wm.workspace."6"} = "workspace number 6";
          ${config.keyboard.wm.workspace."7"} = "workspace number 7";
          ${config.keyboard.wm.workspace."8"} = "workspace number 8";
          ${config.keyboard.wm.workspace."9"} = "workspace number 9";

          ${config.keyboard.wm.moveToWorkspace."1"} = "move container to workspace number 1";
          ${config.keyboard.wm.moveToWorkspace."2"} = "move container to workspace number 2";
          ${config.keyboard.wm.moveToWorkspace."3"} = "move container to workspace number 3";
          ${config.keyboard.wm.moveToWorkspace."4"} = "move container to workspace number 4";
          ${config.keyboard.wm.moveToWorkspace."5"} = "move container to workspace number 5";
          ${config.keyboard.wm.moveToWorkspace."6"} = "move container to workspace number 6";
          ${config.keyboard.wm.moveToWorkspace."7"} = "move container to workspace number 7";
          ${config.keyboard.wm.moveToWorkspace."8"} = "move container to workspace number 8";
          ${config.keyboard.wm.moveToWorkspace."9"} = "move container to workspace number 9";

          ${config.keyboard.wm.reload} = "reload";
          ${config.keyboard.wm.exit} = "exec ${swayMsgPath} exit";

          ${config.keyboard.wm.resize} = "mode resize";

          "--no-repeat Mod4+x" = incVol "-";
          "--no-repeat Mod4+Shift+x" = incVol "+";
          "--no-repeat Mod4+z" = toggleMuteSources;
        };
      };
    };
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
