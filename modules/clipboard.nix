{ lib, ... }:
{
  flake.modules = {
    homeManager.gui =
      {
        config,
        pkgs,
        ...
      }:
      let
        rofi-cliphist = pkgs.writeShellApplication {
          name = "rofi-cliphist";
          runtimeInputs = [
            config.services.cliphist.package
            config.programs.rofi.package
          ];
          text = ''
            prompt=' 󰆏 '
            content=$(cliphist list | rofi -dmenu -p "$prompt")
            decoded=$(cliphist decode <<<"$content")

            echo "$decoded" | wl-copy
          '';
        };
      in
      {
        services.cliphist.enable = true;

        wayland.windowManager.hyprland.settings.bind = [
          "SUPER, p, exec, ${lib.getExe rofi-cliphist} copy"
        ];

        home.packages = with pkgs; [
          wl-clipboard-rs
        ];
      };

    nixvim.base.clipboard.register = "unnamedplus";
  };
}
