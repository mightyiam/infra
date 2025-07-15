{
  flake.modules.nixos.pc = nixosArgs: {
    nix.nixPath = [
      "nixpkgs=${nixosArgs.config.nixpkgs.flake.source}"
    ];
  };
}
