{pkgs, ...}: {
  nix.package = pkgs.nixVersions.latest;
  nix.settings.auto-optimise-store = true;
}
