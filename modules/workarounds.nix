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

    # evaluation warning: The default value of `gtk.gtk4.theme` has changed from `config.gtk.theme` to `null`.
    #                     You are currently using the legacy default config.gtk.theme`) because `home.stateVersion` is less than "26.05".
    #                     To silence this warning and keep legacy behavior, set:
    #                       gtk.gtk4.theme = config.gtk.theme;
    #                     To adopt the new default behavior, set:
    #                       gtk.gtk4.theme = null;
    gtk.gtk4.theme = null;
  };

  nixpkgs.overlays = [
    # TODO closed upstream
    # https://github.com/NixOS/nixpkgs/issues/514113
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];
}
