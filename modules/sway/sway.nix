{ lib, ... }:
{
  flake.modules.homeManager.gui =
    {
      options,
      pkgs,
      config,
      ...
    }:
    let
      mod = config.wayland.windowManager.sway.config.modifier;
    in
    {
      imports = [
        {
          wayland.windowManager.sway.config.keybindings =
            (options.wayland.windowManager.sway.config.type.getSubOptions { }).keybindings.default;
        }
      ];
      config = {
        wayland.windowManager.sway = {
          enable = true;
          wrapperFeatures.gtk = true;
          extraSessionCommands = ''
            export MOZ_ENABLE_WAYLAND=1
          '';

          config = {
            fonts.size = config.fonts.default.size;

            input = {
              "type:keyboard" = {
                xkb_layout = "us,il";
                xkb_options = "grp:lalt_lshift_toggle";
                repeat_delay = "200";
                repeat_rate = "50";
              };
              "type:touchpad".tap = "enabled";
            };

            workspaceLayout = "tabbed";

            modifier = "Mod4";

            keybindings = {
              "${mod}+Shift+e" = null;
              "--no-repeat ${mod}+Shift+e" =
                "exec ${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} exit";
              "${mod}+Shift+a" = "focus child";
            };
          };
        };
        xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];

        home.packages = with pkgs; [
          wl-clipboard
          wl-color-picker
          xdg-utils
        ];
      };
    };
}
