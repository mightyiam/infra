{
  home.gui = hmArgs: let
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
    wayland.windowManager.hyprland.extraConfig = ''
      source = ${hyprlandConfPath}
    '';
    home.activation.hyprlandStatefulMonitorsFile = hmArgs.lib.hm.dag.entryAfter ["writeBoundary"] ''
      run touch ${hyprlandConfPath}
    '';
  };
}
