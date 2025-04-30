{ inputs, ... }:
{
  flake.modules.nixos.pc.nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
  ];
}
