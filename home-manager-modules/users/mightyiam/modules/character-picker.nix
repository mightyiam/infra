{
  config,
  pkgs,
  lib,
  ...
}:
let
  rofimoji = pkgs.rofimoji.override {
    rofi = pkgs.rofi-wayland;
  };
in
{
  home.packages = [ rofimoji ];
  wayland.windowManager.sway.config.keybindings =
    let
      mod = config.wayland.windowManager.sway.config.modifier;
    in
    {
      "--no-repeat ${mod}+u" = "exec ${lib.getExe rofimoji}";
      "--no-repeat ${mod}+Shift+u" = "exec ${lib.getExe rofimoji} --files all";
    };
}
