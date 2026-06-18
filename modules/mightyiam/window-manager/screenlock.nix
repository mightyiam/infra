{lib, ...}: {
  nixos.modules.pc.security.pam.services.swaylock = {};

  home.gui = {pkgs, ...}: let
    lockCommand = lib.getExe pkgs.swaylock;
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
          command = "${lib.getExe pkgs.dpms-all} off";
          resumeCommand = "${lib.getExe pkgs.dpms-all} on";
        }
      ];
    };
  };
}
