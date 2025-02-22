{ pkgs, ... }:
let
  generation-manager = pkgs.rustPlatform.buildRustPackage {
    pname = "generation-manager";
    version = "1.0.0";
    src = ./.;
    useFetchCargoVendor = true;
    cargoHash = "sha256-AiRGXB6/LjM1WCMvHP5KeCnlruPaRWvwGPjATlf8sTA=";
  };
in
{
  home.packages = [ generation-manager ];
}
