{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      pkgs,
      config,
      ...
    }:
    let
      rofi-type = pkgs.writeShellScript "rofi-type" ''
        CMD=$(${lib.getExe config.programs.rofi.package} -dmenu -p '   ')
        echo "type $($CMD)" | ${config.dotoolc}
      '';

      mod = config.wayland.windowManager.sway.config.modifier;
    in
    {
      wayland.windowManager.sway.config.keybindings."--no-repeat ${mod}+t" = "exec ${rofi-type}";
    };
}
