{
  inputs,
  lib,
  withSystem,
  ...
}: {
  config = {
    flake-file.inputs.nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    perSystem = {
      system,
      pkgs,
      ...
    }: {
      imports = ["${inputs.nixpkgs}/nixos/modules/misc/nixpkgs.nix"];
      nixpkgs.hostPlatform = {inherit system;};
      legacyPackages = pkgs;
    };

    nixos.modules.base = nixosArgs: {
      nixpkgs.pkgs = withSystem nixosArgs.config.hardware.facter.report.system (lib.getAttr "pkgs");
    };
  };
}
