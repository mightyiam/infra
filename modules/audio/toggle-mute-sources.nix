{lib, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      toggle-mute-sources = prev.callPackage ./toggle-mute-sources.pkg.nix {};
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {inherit (pkgs) toggle-mute-sources;};
  };

  homeManager.modules.gui = {pkgs, ...}: {
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, z, exec, ${lib.getExe pkgs.toggle-mute-sources}"
    ];

    home.packages = [pkgs.toggle-mute-sources];
  };
}
