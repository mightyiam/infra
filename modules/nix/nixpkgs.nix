{ rootPath, ... }:
{
  flake.modules.nixos.pc.nix.nixPath = [
    "nixpkgs=${rootPath + "/patched-inputs/nixpkgs"}"
  ];
}
