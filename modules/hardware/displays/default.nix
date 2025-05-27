{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      command = ''${lib.getExe' pkgs.systemd "systemctl"} --user start "way-displays@$XDG_VTNR".service'';
    in
    {
      imports = [ ./_way-displays.nix ];

      services.way-displays-stateful.enable = true;

      wayland.windowManager = {
        sway.config.startup = [ { inherit command; } ];
        hyprland.settings.exec-once = [ command ];
      };
    };
}
