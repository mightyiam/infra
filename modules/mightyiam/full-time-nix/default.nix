{
  nixpkgs.overlays = [
    (final: prev: {
      ftn-advertise = prev.callPackage ./ftn-advertise.pkg.nix {};
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {inherit (pkgs) ftn-advertise;};
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.ftn-advertise];
  };
}
