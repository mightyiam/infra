{lib, ...}: {
  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.rofimoji];

    xdg.configFile."rofimoji.rc".text = lib.generators.toKeyValue {} {
      skin-tone = "medium-light";
    };

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, u, exec, ${lib.getExe pkgs.rofimoji}"
      "SUPER+Shift, u, exec, ${lib.getExe pkgs.rofimoji} --files all"
    ];
  };
}
