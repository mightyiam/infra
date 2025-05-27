{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      command = ''${lib.getExe' pkgs.systemd "systemctl"} --user start "way-displays@$XDG_VTNR".service'';
    in
    {
      services.way-displays = {
        enable = true;
        statefulConfiguration = true;
        settings = null;
      };

      wayland.windowManager = {
        sway.config.startup = [ { inherit command; } ];
        hyprland.settings.exec-once = [ command ];
      };
    };
}
