{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit
    (lib)
    concatStringsSep
    mkIf
    ;

  keyboard = import ../keyboard.nix;
  step = 5;
  pactl = pkgs.pulseaudio + /bin/pactl;
  incVol = d:
    concatStringsSep " " [
      "exec ${pactl}"
      "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
    ];
  toggleMuteSources = concatStringsSep " " [
    "exec ${pkgs.zsh + /bin/zsh} -c '"
    "for source in $(${pactl} list short sources | ${pkgs.gawk + /bin/awk} \"{print \\$2}\");"
    "do ${pactl} set-source-mute \"$source\" toggle;"
    "done'"
  ];
  swayMsgPath = config.wayland.windowManager.sway.package + /bin/swaymsg;
in
  mkIf config.gui.enable {
    wayland.windowManager.sway.enable = true;
    wayland.windowManager.sway.wrapperFeatures.gtk = true;
    wayland.windowManager.sway.extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
    '';
    wayland.windowManager.sway.config.fonts.size = (import ../fonts.nix).default.size;
    wayland.windowManager.sway.config.input."type:keyboard".xkb_layout = "us,il";
    wayland.windowManager.sway.config.input."type:keyboard".xkb_options = "grp:lalt_lshift_toggle";
    wayland.windowManager.sway.config.input."type:keyboard".repeat_delay = "200";
    wayland.windowManager.sway.config.input."type:keyboard".repeat_rate = "50";
    wayland.windowManager.sway.config.input."type:touchpad".tap = "enabled";
    wayland.windowManager.sway.config.terminal = "false";
    wayland.windowManager.sway.config.modifier = "Mod4";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.terminal} = "exec ${config.programs.alacritty.package + /bin/alacritty}";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.kill} = "kill";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.menu} = "exec ${config.wayland.windowManager.sway.config.menu}";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.focus.left} = "focus left";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.focus.down} = "focus down";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.focus.up} = "focus up";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.focus.right} = "focus right";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.focus.parent} = "focus parent";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.move.left} = "move left";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.move.down} = "move down";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.move.up} = "move up";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.move.right} = "move right";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.fullscreen} = "fullscreen toggle";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.layout.tabbed} = "layout tabbed";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.layout.toggleSplit} = "layout toggle split";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.floatingToggle} = "floating toggle";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.focusModeToggle} = "focus mode_toggle";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."1"} = "workspace number 1";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."2"} = "workspace number 2";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."3"} = "workspace number 3";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."4"} = "workspace number 4";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."5"} = "workspace number 5";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."6"} = "workspace number 6";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."7"} = "workspace number 7";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."8"} = "workspace number 8";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.workspace."9"} = "workspace number 9";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."1"} = "move container to workspace number 1";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."2"} = "move container to workspace number 2";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."3"} = "move container to workspace number 3";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."4"} = "move container to workspace number 4";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."5"} = "move container to workspace number 5";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."6"} = "move container to workspace number 6";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."7"} = "move container to workspace number 7";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."8"} = "move container to workspace number 8";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.moveToWorkspace."9"} = "move container to workspace number 9";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.reload} = "reload";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.exit} = "exec ${swayMsgPath} exit";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.resize} = "mode resize";

    wayland.windowManager.sway.config.keybindings.${keyboard.wm.volume.decrement} = incVol "-";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.volume.increment} = incVol "+";
    wayland.windowManager.sway.config.keybindings.${keyboard.wm.volume.toggleMuteSources} = toggleMuteSources;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
  }
