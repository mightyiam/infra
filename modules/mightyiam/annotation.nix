{lib, ...}: {
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
