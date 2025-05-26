{ lib, ... }:
{
  flake.modules.homeManager.gui =
    {
      config,
      pkgs,
      ...
    }:
    let
      rofimoji = pkgs.rofimoji;
    in
    {
      home.packages = [ rofimoji ];

      wayland.windowManager = {
        sway.config.keybindings =
          let
            mod = config.wayland.windowManager.sway.config.modifier;
          in
          {
            "--no-repeat ${mod}+u" = "exec ${lib.getExe rofimoji}";
            "--no-repeat ${mod}+Shift+u" = "exec ${lib.getExe rofimoji} --files all";
          };

        hyprland.settings.bind = [
          "SUPER, u, exec, ${lib.getExe rofimoji}"
          "SUPER+Shift, u, exec, ${lib.getExe rofimoji} --files all"
        ];
      };
    };
}
