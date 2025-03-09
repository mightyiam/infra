{ inputs, ... }:
{
  flake.modules.nixos.desktop.nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
  ];
}
