{ pkgs, ... }:
let
  generation-manager = pkgs.rustPlatform.buildRustPackage {
    pname = "generation-manager";
    version = "1.0.0";
    src = ./.;
    cargoHash = "sha256-IrgdeufcGE4lQxTLz0m1mgIOCCsHCJdU77WOkV6ExvA=";
  };
in
{
  home.packages = [ generation-manager ];
}
