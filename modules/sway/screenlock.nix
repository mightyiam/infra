{
  flake.modules = {
    nixos.pc.security.pam.services.swaylock = { };

    homeManager.gui =
      {
        pkgs,
        config,
        ...
      }:
      let
        lockCommand = pkgs.swaylock + /bin/swaylock;
        swayMsgPath = config.wayland.windowManager.sway.package + /bin/swaymsg;
      in
      {
        wayland.windowManager.sway.config.keybindings."Mod4+Ctrl+l" = "exec ${lockCommand}";
        programs.swaylock = {
          enable = true;
          settings = {
            daemonize = true;
            show-keyboard-layout = true;
            indicator-caps-lock = true;
            indicator-radius = 200;
          };
        };
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
      };
  };
}
