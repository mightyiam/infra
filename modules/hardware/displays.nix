{
  flake.modules.homeManager.gui =
    hmArgs:
    let
      # https://wiki.hypr.land/Configuring/Monitors, example:
      #
      # ```
      # monitor = desc:Microstep Optix G24C 0000000000001, 1920x1080@144, auto-center, 1
      # monitor = desc:AOC 24V2W1G5 0x000006C2           , 1920x1080@75 , auto-left  , 1
      # ```
      hyprlandConfPath = "${hmArgs.config.xdg.configHome}/hypr/monitors.conf";
    in
    {
      wayland.windowManager.hyprland.extraConfig = ''
        source = ${hyprlandConfPath}
      '';
      home.activation.hyprlandStatefulMonitorsFile = hmArgs.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run touch ${hyprlandConfPath}
      '';
    };
}
