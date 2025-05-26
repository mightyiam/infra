{ lib, withSystem, ... }:
{
  flake.modules.homeManager.base =
    {
      pkgs,
      config,
      ...
    }:
    let
      sink-rotate = withSystem pkgs.system ({ inputs', ... }: inputs'.sink-rotate.packages.default);
      mod = config.wayland.windowManager.sway.config.modifier;
    in
    {
      home.packages = [ sink-rotate ];
      wayland.windowManager = {
        sway.config.keybindings = {
          "--no-repeat ${mod}+c" = "exec ${lib.getExe sink-rotate}";
        };
        hyprland.settings.bind = [
          "SUPER, c, exec, ${lib.getExe sink-rotate}"
        ];
      };
    };
}
