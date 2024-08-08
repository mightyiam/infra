{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;

  inherit (config) keyboard;
  shotman = "${pkgs.shotman}/bin/shotman --capture";
in
mkIf config.gui.enable {
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.screenshot.window
  }" = "exec ${shotman} window";
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.screenshot.output
  }" = "exec ${shotman} output";
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.screenshot.region
  }" = "exec ${shotman} region";
}
