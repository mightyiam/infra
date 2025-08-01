{
  flake.modules.nixos.base = nixosArgs: {
    nix.nixPath = [
      "nixpkgs=${nixosArgs.config.nixpkgs.flake.source}"
    ];
  };
}
