{
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        hyprcwd = prev.callPackage ./hyprcwd.pkg.nix {};
      })
    ];
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.hyprcwd];
  };
}
