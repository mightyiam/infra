{
  flake.modules = {
    nixos = {
      base = {
        # https://github.com/NixOS/nixpkgs/issues/263289
        environment.defaultPackages = [ ];
      };
      pc = {
        # https://github.com/nix-community/stylix/discussions/2232
        stylix.targets.gtksourceview.enable = false;
      };
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
