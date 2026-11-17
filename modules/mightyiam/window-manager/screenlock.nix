{lib, ...}: {
  nixos.modules.pc.security.pam.services.swaylock = {};

  home.gui = {pkgs, ...}: let
    lockCommand = lib.getExe pkgs.swaylock;
  in {
    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + SHIFT + ALT + l"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lockCommand}")'')
        ];
      }
      {
        _args = [
          "SUPER + ALT + l"
          (lib.generators.mkLuaInline ''
            function()
              hl.dispatch(hl.dsp.exec_cmd("${lockCommand}"))
              hl.dispatch(hl.dsp.exec_cmd("systemctl suspend"))
            end
          '')
        ];
      }
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
