{lib, ...}: {
  home.gui = {pkgs, ...}: let
    package = pkgs.rofi-rbw-wayland;
  in {
    home.packages = [package];

    xdg.configFile."rofi-rbw.rc".text = lib.generators.toINIWithGlobalSection {} {
      # https://github.com/fdw/rofi-rbw#configuration
      globalSection = {};
    };

    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + m"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe package}")'')
        ];
      }
    ];
  };
}
