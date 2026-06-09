{
  nixos.modules.base = {
    # https://github.com/NixOS/nixpkgs/issues/263289
    environment.defaultPackages = [];

    stylix.targets = {
      # TODO look at this again
      # https://github.com/danth/stylix/discussions/1206
      grub.enable = false;

      # https://github.com/nix-community/stylix/discussions/2232
      gtksourceview.enable = false;
    };
  };
  homeManager.modules.base = {
    # https://github.com/nix-community/stylix/discussions/2232
    stylix.targets.gtksourceview.enable = false;

    # 2026-05-27: found that cursor was not present in entire screen sharing.
    # This seems to workaround that.
    wayland.windowManager.hyprland.settings.cursor.no_hardware_cursors = 1;
  };

  nixpkgs.overlays = [
  ];
}
