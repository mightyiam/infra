{ lib, withSystem, ... }:
let
  mode = "privacy";
in
{
  perSystem =
    psArgs@{ pkgs, ... }:
    {
      packages = {
        notification-privacy-off = pkgs.writeShellApplication {
          name = "notification-privacy-off";
          runtimeInputs = [ pkgs.mako ];
          text = ''
            makoctl mode -r ${mode}
          '';
        };
        notification-privacy-on = pkgs.writeShellApplication {
          name = "notification-privacy-on";
          runtimeInputs = [ pkgs.mako ];
          text = ''
            makoctl mode -a ${mode}
          '';
        };
        handle-hyprland-screencast = pkgs.writeShellApplication {
          name = "handle-hyprland-screencast";
          runtimeInputs = [
            pkgs.socat
            psArgs.config.packages.notification-privacy-off
            psArgs.config.packages.notification-privacy-on
          ];
          text = ''
            handle() {
              case $1 in
                "screencast>>0"*) notification-privacy-off ;;
                "screencast>>1"*) notification-privacy-on ;;
              esac
            }

            socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
            | while read -r line; do handle "$line"; done
          '';
        };
      };
    };

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      services.mako = {
        enable = true;
        settings = {
          anchor = "top-right";
          default-timeout = 3000;
          ignore-timeout = 1;
          "mode=${mode}".invisible = 1;
        };
      };
      xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
        [screencast]
        exec_before=${
          withSystem pkgs.stdenv.hostPlatform.system (
            psArgs: lib.getExe psArgs.config.packages.notification-privacy-on
          )
        }
        exec_after=${
          withSystem pkgs.stdenv.hostPlatform.system (
            psArgs: lib.getExe psArgs.config.packages.notification-privacy-off
          )
        }
      '';
      services.systembus-notify.enable = true;

      wayland.windowManager.hyprland.settings.exec-once = [
        (withSystem pkgs.stdenv.hostPlatform.system (
          psArgs: lib.getExe psArgs.config.packages.handle-hyprland-screencast
        ))
      ];
    };
}
