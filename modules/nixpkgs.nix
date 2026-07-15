{inputs, ...}: {
  config = {
    flake-file.inputs.nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    perSystem = psArgs @ {
      system,
      pkgs,
      ...
    }: {
      imports = ["${inputs.nixpkgs}/nixos/modules/misc/nixpkgs.nix"];
      nixpkgs.hostPlatform = {inherit system;};
      _module.args = psArgs.config.nixpkgs.pkgs;
      legacyPackages = pkgs;
    };
  };
}
