{lib, ...}: {
  home.gui = hmArgs: let
    wpaperctl = lib.getExe' hmArgs.config.services.wpaperd.package "wpaperctl";
  in {
    wayland.windowManager.hyprland = {
      settings.config.misc.disable_hyprland_logo = true;

      settings.bind = [
        {
          _args = [
            "SUPER + i"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${wpaperctl} next-wallpaper")'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + i"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${wpaperctl} previous-wallpaper")'')
          ];
        }
      ];
    };

    services.wpaperd = {
      enable = true;
      settings.default = {
        path = "${hmArgs.config.home.homeDirectory}/backgrounds";
        duration = "4h";
        sorting = "random";
        queue-size = 20;
        mode = "center";
      };
    };
  };
}
