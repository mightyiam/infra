{
  perSystem = {pkgs, ...}: {
    nixpkgs.overlays = [
      (final: prev: {
        mightyi-dot-am = prev.callPackage ./bundle.pkg.nix {};
      })
    ];

    checks = {inherit (pkgs) mightyi-dot-am;};
  };
}
