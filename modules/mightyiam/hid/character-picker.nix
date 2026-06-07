{lib, ...}: {
  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.rofimoji];

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, u, exec, ${lib.getExe pkgs.rofimoji}"
      "SUPER+Shift, u, exec, ${lib.getExe pkgs.rofimoji} --files all"
    ];
  };
}
