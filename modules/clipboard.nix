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
        mod = config.wayland.windowManager.sway.config.modifier;

        rofi-cliphist = pkgs.writeShellApplication {
          name = "rofi-cliphist";
          runtimeInputs = [
            config.services.cliphist.package
            config.programs.rofi.package
          ];
          text = ''
            prompt=$(if [ "$1" == "copy" ]; then echo ' 󰆏 '; else echo '   '; fi)
            content=$(cliphist list | rofi -dmenu -p "$prompt")
            decoded=$(cliphist decode <<<"$content")

            if [ "$1" == "copy" ]; then
              echo "$decoded" | wl-copy
            else
              echo "type $decoded" | ${config.dotoolc}
            fi
          '';
        };
      in
      {
        services.cliphist.enable = true;

        wayland.windowManager.sway.config.keybindings = {
          "--no-repeat ${mod}+p" = "exec ${lib.getExe rofi-cliphist} copy";
          "--no-repeat ${mod}+Shift+p" = "exec ${lib.getExe rofi-cliphist} type";
        };
      };

    nixvim.astrea.clipboard.register = "unnamedplus";
  };
}
