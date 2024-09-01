{ pkgs, self, ... }:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings.auto-optimise-store = true;
  nix.nixPath = [
    "nixpkgs=${self.inputs.nixpkgs}"
  ];
}
