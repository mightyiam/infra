{
  pkgs,
  config,
  lib,
  ...
}:
let
  shotman = "${pkgs.shotman}/bin/shotman --capture";
in
lib.mkIf config.gui.enable {
  wayland.windowManager.sway.config.keybindings."${config.keyboard.wm.screenshot.window
  }" = "exec ${shotman} window";
  wayland.windowManager.sway.config.keybindings."${config.keyboard.wm.screenshot.output
  }" = "exec ${shotman} output";
  wayland.windowManager.sway.config.keybindings."${config.keyboard.wm.screenshot.region
  }" = "exec ${shotman} region";
}
