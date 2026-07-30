{lib, ...}: {
  home.gui = hmArgs @ {pkgs, ...}: let
    # https://wiki.hypr.land/Configuring/Monitors, example:
    #
    # ``` hyprlang
    # monitorv2 {
    #   output = DP-1
    #   mode = 1920x1080@60
    #   position = auto-right
    #   scale = 1
    # }
    # monitorv2 {
    #   output = HDMI-A-1
    #   mode = 1920x1080@75
    #   position = auto-left
    #   scale = 1
    # }
    # ```
    hyprlandConfPath = "${hmArgs.config.xdg.configHome}/hypr/monitors.conf";
  in {
    wayland.windowManager.hyprland = {
      extraConfig = ''
        source = ${hyprlandConfPath}
      '';
      settings.bind = [
        "SUPER, b, exec, ${lib.getExe pkgs.brightnessctl} set 10%-"
        "SUPER+SHIFT, b, exec, ${lib.getExe pkgs.brightnessctl} set 10%+"
      ];
    };
    home = {
      packages = [pkgs.brightnessctl];
      activation.hyprlandStatefulMonitorsFile = hmArgs.lib.hm.dag.entryAfter ["writeBoundary"] ''
        run touch ${hyprlandConfPath}
      '';
    };
  };
}
