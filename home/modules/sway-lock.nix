with builtins;
  {
    pkgs,
    config,
    ...
  }: let
    keyboard = import ../keyboard.nix;
    lockCommand = concatStringsSep " " [
      (pkgs.swaylock + /bin/swaylock)
      "--daemonize"
      "--show-keyboard-layout"
      "--indicator-caps-lock"
      "--color 000000"
      "--indicator-radius 200"
    ];
    swayMsgPath = config.wayland.windowManager.sway.package + /bin/swaymsg;
  in {
    wayland.windowManager.sway.config.keybindings."${keyboard.wm.lock}" = "exec ${lockCommand}";
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 60 * 10;
          command = lockCommand;
        }
        {
          timeout = 60 * 11;
          command = "${swayMsgPath} \"output * dpms off\"";
          resumeCommand = "${swayMsgPath} \"output * dpms on\"";
        }
      ];
    };
  }
