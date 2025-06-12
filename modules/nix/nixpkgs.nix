{ rootPath, lib, ... }:
{
  flake.modules.nixos.pc = nixosArgs: {
    nixpkgs.flake.source = lib.mkForce (rootPath + "/patched-inputs/nixpkgs");
    nix.nixPath = [
      "nixpkgs=${nixosArgs.config.nixpkgs.flake.source}"
    ];
  };
}
