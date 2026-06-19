{lib, ...}: let
  toggle-mute-sources = {
    writeShellApplication,
    pulseaudio,
    gawk,
  }:
    writeShellApplication {
      name = "toggle-mute-sources";
      runtimeInputs = [
        pulseaudio
        gawk
      ];
      text = ''
        for source in $(pactl list short sources | awk "{print \$2}");
        do pactl set-source-mute "$source" toggle;
        done
      '';
    };
in {
  nixpkgs.overlays = [
    (final: prev: {
      # TODO rewrite in Nushell
      toggle-mute-sources = prev.callPackage toggle-mute-sources {};
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
