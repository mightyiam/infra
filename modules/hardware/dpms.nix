{
  nixpkgs.overlays = [
    (final: prev: {
      dpms-all = prev.callPackage ./dpms-all.pkg.nix {};
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {inherit (pkgs) dpms-all;};
  };

  nixos.modules.base = {
    services.kmscon.config.dmps-timeout = 60;
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.dpms-all];
  };
}
