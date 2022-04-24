with builtins;
  {
    pkgs,
    lib,
    config,
    ...
  }: let
    modKey = "Mod4";
    instance = import ../instance.nix;
    secrets = import ../secrets.nix;
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
      ...
    }: {
      name = path;
      value = {
        res = with resolution; "${toString width}x${toString height}@${toString refreshRate}Hz";
        pos = with position; "${toString x} ${toString y}";
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
        modifier = modKey;
        input = {
          "type:keyboard" = {
            xkb_layout = "us,il";
            xkb_options = "grp:lalt_lshift_toggle";
          };
        };
        terminal = "false";
        keybindings = {
          "${modKey}+Return" = "exec ${config.programs.alacritty.package + /bin/alacritty}";
          "${modKey}+Shift+q" = "kill";
          "${modKey}+d" = "exec ${config.wayland.windowManager.sway.config.menu}";

          "${modKey}+h" = "focus left";
          "${modKey}+j" = "focus down";
          "${modKey}+k" = "focus up";
          "${modKey}+l" = "focus right";

          "${modKey}+Shift+h" = "move left";
          "${modKey}+Shift+j" = "move down";
          "${modKey}+Shift+k" = "move up";
          "${modKey}+Shift+l" = "move right";

          "${modKey}+b" = "splith";
          "${modKey}+v" = "splitv";
          "${modKey}+f" = "fullscreen toggle";
          "${modKey}+a" = "focus parent";

          "${modKey}+s" = "layout stacking";
          "${modKey}+w" = "layout tabbed";
          "${modKey}+e" = "layout toggle split";

          "${modKey}+Shift+space" = "floating toggle";
          "${modKey}+space" = "focus mode_toggle";

          "${modKey}+1" = "workspace number 1";
          "${modKey}+2" = "workspace number 2";
          "${modKey}+3" = "workspace number 3";
          "${modKey}+4" = "workspace number 4";
          "${modKey}+5" = "workspace number 5";
          "${modKey}+6" = "workspace number 6";
          "${modKey}+7" = "workspace number 7";
          "${modKey}+8" = "workspace number 8";
          "${modKey}+9" = "workspace number 9";

          "${modKey}+Shift+1" = "move container to workspace number 1";
          "${modKey}+Shift+2" = "move container to workspace number 2";
          "${modKey}+Shift+3" = "move container to workspace number 3";
          "${modKey}+Shift+4" = "move container to workspace number 4";
          "${modKey}+Shift+5" = "move container to workspace number 5";
          "${modKey}+Shift+6" = "move container to workspace number 6";
          "${modKey}+Shift+7" = "move container to workspace number 7";
          "${modKey}+Shift+8" = "move container to workspace number 8";
          "${modKey}+Shift+9" = "move container to workspace number 9";

          "${modKey}+Shift+c" = "reload";
          "${modKey}+Shift+e" = "exec ${swayMsgPath} exit";

          "${modKey}+r" = "mode resize";

          "${modKey}+minus" = incVol "-";
          "${modKey}+equal" = incVol "+";
        };
      };
    };
  }
