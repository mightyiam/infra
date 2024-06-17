{
  pkgs,
  lib,
  ...
}: {
  # mkDeafult to avoid conflict with usage as NixOS module
  nix.package = lib.mkDefault pkgs.nix;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.keep-outputs = true;
}
