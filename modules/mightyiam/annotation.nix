{lib, ...}: {
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.vellum];

    xdg.autostart.entries = [
      (pkgs.makeDesktopItem {
          name = "vellum";
          desktopName = "Vellum";
          exec = "vellum";
          terminal = false;
        }
        + "/share/applications/vellum.desktop")
    ];
  };

  home.gui = {pkgs, ...}: {
    wayland.windowManager.hyprland.settings = {
      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.exec_cmd("${lib.getExe pkgs.vellum}")
              end
            '')
          ];
        }
      ];
      bind = [
        {
          _args = [
            "SUPER + g"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.vellum} toggle")'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + g"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.vellum} clear")'')
          ];
        }
      ];
    };
  };
}
