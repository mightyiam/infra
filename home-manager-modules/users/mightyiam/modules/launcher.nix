{
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.sway.config.menu = lib.getExe pkgs.kickoff;
}
