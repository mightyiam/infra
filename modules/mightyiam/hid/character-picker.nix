{lib, ...}: {
  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.rofimoji];

    xdg.configFile."rofimoji.rc".text = lib.generators.toKeyValue {} {
      skin-tone = "medium-light";
    };

    wayland.windowManager.hyprland.settings.bind = [
      {
        _args = [
          "SUPER + u"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofimoji}")'')
        ];
      }
      {
        _args = [
          "SUPER + SHIFT + u"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofimoji} --files all")'')
        ];
      }
    ];
  };
}
