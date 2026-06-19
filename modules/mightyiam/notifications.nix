{lib, ...}: let
  mode = "privacy";
  notification-privacy-off = {
    writeShellApplication,
    mako,
  }:
    writeShellApplication {
      name = "notification-privacy-off";
      runtimeInputs = [mako];
      text = ''
        makoctl mode -r ${mode}
      '';
    };
  notification-privacy-on = {
    writeShellApplication,
    mako,
  }:
    writeShellApplication {
      name = "notification-privacy-on";
      runtimeInputs = [mako];
      text = ''
        makoctl mode -a ${mode}
      '';
    };
  handle-hyprland-screencast = {
    writeShellApplication,
    socat,
    notification-privacy-off,
    notification-privacy-on,
  }:
    writeShellApplication {
      name = "handle-hyprland-screencast";
      runtimeInputs = [
        socat
        notification-privacy-off
        notification-privacy-on
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
in {
  nixpkgs.overlays = [
    (final: prev: {
      notification-privacy-off = prev.callPackage notification-privacy-off {};
      notification-privacy-on = prev.callPackage notification-privacy-on {};
      handle-hyprland-screencast = prev.callPackage handle-hyprland-screencast {};
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
