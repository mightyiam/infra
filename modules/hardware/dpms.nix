{
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        dpms-all = prev.callPackage ./dpms-all.pkg.nix {};
      })
    ];
  };

  nixos.modules.base = {
    services.kmscon.config.dmps-timeout = 60;
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.dpms-all];
  };
}
