{ rootPath, lib, ... }:
{
  flake.modules.nixos.pc = nixosArgs: {
    nixpkgs.flake.source = lib.mkForce (rootPath + "/inputs/nixpkgs");
    nix.nixPath = [
      "nixpkgs=${nixosArgs.config.nixpkgs.flake.source}"
    ];
  };
}
