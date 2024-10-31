{ pkgs, lib, ... }:
{
  nix.package = lib.mkDefault pkgs.nixVersions.latest;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  nix.settings.keep-outputs = true;
}
