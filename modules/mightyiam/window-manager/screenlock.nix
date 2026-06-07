{
  lib,
  withSystem,
  ...
}: {
  nixos.modules.pc.security.pam.services.swaylock = {};

  home.gui = {pkgs, ...}: let
    lockCommand = lib.getExe pkgs.swaylock;
    # TODO via overlay
    dpms-all = withSystem pkgs.stdenv.hostPlatform.system (psArgs: psArgs.config.packages.dpms-all);
  in {
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER+Alt, l, exec, ${lockCommand}"
    ];

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
}
