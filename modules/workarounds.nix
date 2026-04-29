{
  flake.modules = {
    # https://github.com/nix-community/stylix/discussions/2232
    nixos.pc = {
      stylix.targets.gtksourceview.enable = false;
    };
    homeManager.gui = {
      stylix.targets.gtksourceview.enable = false;
    };
  };

  nixpkgs.overlays = [
    # https://github.com/NixOS/nixpkgs/issues/514113
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];
}
