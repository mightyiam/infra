{lib, ...}: {
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        toggle-mute-sources = prev.callPackage ./toggle-mute-sources.pkg.nix {};
      })
    ];
  };

  homeManager.modules.gui = {pkgs, ...}: {
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, z, exec, ${lib.getExe pkgs.toggle-mute-sources}"
    ];

    home.packages = [pkgs.toggle-mute-sources];
  };
}
