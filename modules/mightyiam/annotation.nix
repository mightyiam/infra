{lib, ...}: {
  home.gui = {pkgs, ...}: {
    wayland.windowManager.hyprland.settings = {
      exec-once = [(lib.getExe pkgs.vellum)];
      bind = [
        "SUPER, period, exec, ${lib.getExe pkgs.vellum} toggle"
        "SUPER+SHIFT, period, exec, ${lib.getExe pkgs.vellum} clear"
      ];
    };
  };
}
