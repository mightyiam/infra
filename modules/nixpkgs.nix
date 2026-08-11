{
  inputs,
  lib,
  withSystem,
  ...
}: {
  flake-file.inputs.nixpkgs = {
    url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    flake = false;
  };

  perSystem = {
    system,
    pkgs,
    ...
  }: {
    imports = ["${inputs.nixpkgs}/nixos/modules/misc/nixpkgs.nix"];
    nixpkgs.hostPlatform = {inherit system;};
    legacyPackages = pkgs;
  };

  nixos.modules.base = nixosArgs @ {pkgs, ...}: {
    nixpkgs.pkgs = withSystem nixosArgs.config.hardware.facter.report.system (lib.getAttr "pkgs");
    home-manager.useGlobalPkgs = true;
    nix.nixPath = ["nixpkgs=${pkgs.path}"];
  };
}
