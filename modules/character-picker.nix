{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      config,
      pkgs,
      ...
    }:
    let
      rofimoji = pkgs.rofimoji.override {
        rofi = pkgs.rofi-wayland;
      };
    in
    {
      home.packages = lib.mkIf config.gui.enable [ rofimoji ];
      wayland.windowManager.sway.config.keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        {
          "--no-repeat ${mod}+u" = "exec ${lib.getExe rofimoji}";
          "--no-repeat ${mod}+Shift+u" = "exec ${lib.getExe rofimoji} --files all";
        };
    };
}
