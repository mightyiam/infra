{
  lib,
  withSystem,
  ...
}:
{
  flake.modules = {
    nixos.pc.security.pam.services.swaylock = { };

    homeManager.gui =
      hmArgs@{ pkgs, ... }:
      let
        lockCommand = lib.getExe pkgs.swaylock;
        dpms-all = withSystem pkgs.system (psArgs: psArgs.config.packages.dpms-all);
      in
      {
        wayland.windowManager.sway.config.keybindings =
          let
            mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
          in
          {
            "${mod}+Ctrl+l" = "exec ${lockCommand}";
          };

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
              command = "${lib.getExe dpms-all} off";
              resumeCommand = "${lib.getExe dpms-all} on";
            }
          ];
        };
      };
  };
}
