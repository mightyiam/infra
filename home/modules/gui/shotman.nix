instance: {pkgs, ...}: let
  keyboard = import ../../keyboard.nix;
  shotman = "${pkgs.shotman}/bin/shotman --capture";
in {
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.screenshot.window}" = "exec ${shotman} window";
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.screenshot.output}" = "exec ${shotman} output";
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.screenshot.region}" = "exec ${shotman} region";
}
