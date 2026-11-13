{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.sink-rotate];
    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + c"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.sink-rotate}")'')
        ];
      }
    ];
  };
}
