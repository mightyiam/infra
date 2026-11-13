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
    baseName = "monitors";
    hyprlandConfPath = "${hmArgs.config.xdg.configHome}/hypr/${baseName}.lua";
  in {
    wayland.windowManager.hyprland = {
      extraConfig = ''
        require("${baseName}")
      '';
      settings.bind = [
        {
          _args = [
            "SUPER + b"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} set 2%-")'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + b"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} set 2%+")'')
          ];
        }
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
