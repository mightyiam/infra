{lib, ...}: let
  mode = "privacy";
in {
  nixpkgs.overlays = [
    (final: prev: {
      notification-privacy-off = prev.writeShellApplication {
        name = "notification-privacy-off";
        runtimeInputs = [prev.mako];
        text = ''
          makoctl mode -r ${mode}
        '';
      };
      notification-privacy-on = prev.writeShellApplication {
        name = "notification-privacy-on";
        runtimeInputs = [prev.mako];
        text = ''
          makoctl mode -a ${mode}
        '';
      };
      handle-hyprland-screencast = prev.writeShellApplication {
        name = "handle-hyprland-screencast";
        runtimeInputs = [
          prev.socat
          final.notification-privacy-off
          final.notification-privacy-on
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
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {
      inherit (pkgs) notification-privacy-off notification-privacy-on handle-hyprland-screencast;
    };
  };

  home.gui = {pkgs, ...}: {
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
      exec_before=${lib.getExe pkgs.notification-privacy-on}
      exec_after=${lib.getExe pkgs.notification-privacy-off}
    '';
    services.systembus-notify.enable = true;

    wayland.windowManager.hyprland.settings.exec-once = [
      (lib.getExe pkgs.handle-hyprland-screencast)
    ];
  };
}
