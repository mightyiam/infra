with builtins;
  instance: {
    pkgs,
    lib,
    config,
    ...
  }: let
    keyboard = import ../keyboard.nix;
    step = 5;
    incVol = d:
      concatStringsSep " " [
        "exec ${pkgs.pulseaudio + /bin/pactl}"
        "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
      ];
    toSwayOutput = _: {
      path,
      resolution,
      refreshRate,
      position,
      scale,
      ...
    }: {
      name = path;
      value = {
        res = with resolution; "${toString width}x${toString height}@${toString refreshRate}Hz";
        pos = with position; "${toString x} ${toString y}";
        scale = toString scale;
        background = "${(import ../gruvbox.nix).colors.dark0} solid_color";
      };
    };
    swayMsgPath = config.wayland.windowManager.sway.package + /bin/swaymsg;
  in {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraSessionCommands = ''
        export MOZ_ENABLE_WAYLAND=1
      '';
      config = {
        output = listToAttrs (attrValues (mapAttrs toSwayOutput instance.outputs));
        fonts.size = (import ../fonts.nix).default.size;
        input = {
          "type:keyboard" = {
            xkb_layout = "us,il";
            xkb_options = "grp:lalt_lshift_toggle";
          };
        };
        terminal = "false";
        modifier = "Mod4";
        keybindings = with keyboard.wm; {
          "${terminal}" = "exec ${config.programs.alacritty.package + /bin/alacritty}";
          "${kill}" = "kill";
          "${menu}" = "exec ${config.wayland.windowManager.sway.config.menu}";

          "${focus.left}" = "focus left";
          "${focus.down}" = "focus down";
          "${focus.up}" = "focus up";
          "${focus.right}" = "focus right";

          "${move.left}" = "move left";
          "${move.down}" = "move down";
          "${move.up}" = "move up";
          "${move.right}" = "move right";

          "${fullscreen}" = "fullscreen toggle";

          "${layout.tabbed}" = "layout tabbed";
          "${layout.toggleSplit}" = "layout toggle split";

          "${floatingToggle}" = "floating toggle";
          "${focusModeToggle}" = "focus mode_toggle";

          "${workspace."1"}" = "workspace number 1";
          "${workspace."2"}" = "workspace number 2";
          "${workspace."3"}" = "workspace number 3";
          "${workspace."4"}" = "workspace number 4";
          "${workspace."5"}" = "workspace number 5";
          "${workspace."6"}" = "workspace number 6";
          "${workspace."7"}" = "workspace number 7";
          "${workspace."8"}" = "workspace number 8";
          "${workspace."9"}" = "workspace number 9";

          "${moveToWorkspace."1"}" = "move container to workspace number 1";
          "${moveToWorkspace."2"}" = "move container to workspace number 2";
          "${moveToWorkspace."3"}" = "move container to workspace number 3";
          "${moveToWorkspace."4"}" = "move container to workspace number 4";
          "${moveToWorkspace."5"}" = "move container to workspace number 5";
          "${moveToWorkspace."6"}" = "move container to workspace number 6";
          "${moveToWorkspace."7"}" = "move container to workspace number 7";
          "${moveToWorkspace."8"}" = "move container to workspace number 8";
          "${moveToWorkspace."9"}" = "move container to workspace number 9";

          "${reload}" = "reload";
          "${exit}" = "exec ${swayMsgPath} exit";

          "${resize}" = "mode resize";

          "${volume.decrement}" = incVol "-";
          "${volume.increment}" = incVol "+";
        };
      };
    };
  }
