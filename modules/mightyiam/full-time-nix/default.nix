{
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        ftn-advertise = prev.callPackage ./ftn-advertise.pkg.nix {};
      })
    ];
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.ftn-advertise];
  };
}
