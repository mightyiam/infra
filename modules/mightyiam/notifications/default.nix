{lib, ...}: let
  mode = "privacy";
in {
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        notification-privacy-off = prev.callPackage ./notification-privacy-off.pkg.nix {inherit mode;};
        notification-privacy-on = prev.callPackage ./notification-privacy-on.pkg.nix {inherit mode;};
        handle-hyprland-screencast = prev.callPackage ./handle-hyprland-screencast.pkg.nix {};
      })
    ];
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

    wayland.windowManager.hyprland.settings.on = [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("${lib.getExe pkgs.handle-hyprland-screencast}")
            end
          '')
        ];
      }
    ];

    home.packages = [pkgs.notify-desktop];
  };
}
