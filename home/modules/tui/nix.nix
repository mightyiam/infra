{pkgs, ...}: {
  nix.package = pkgs.nix;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.keep-outputs = true;
}
