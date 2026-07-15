{lib, ...}: {
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        rofi-cliphist = prev.callPackage ./rofi-cliphist.pkg.nix {};
      })
    ];
  };

  home.gui = {pkgs, ...}: {
    services.cliphist.enable = true;

    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, p, exec, ${lib.getExe pkgs.rofi-cliphist} copy"
    ];

    home.packages = with pkgs; [
      wl-clipboard-rs
    ];
  };

  armilaria = {
    clipboard.register = "unnamedplus";
  };
}
