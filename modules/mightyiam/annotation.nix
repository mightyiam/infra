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
      exec-once = [(lib.getExe pkgs.vellum)];
      bind = [
        "SUPER, g, exec, ${lib.getExe pkgs.vellum} toggle"
        "SUPER+SHIFT, g, exec, ${lib.getExe pkgs.vellum} clear"
      ];
    };
  };
}
