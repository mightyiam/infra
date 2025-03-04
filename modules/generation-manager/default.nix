{
  flake.modules.homeManager.generation-manager =
    { pkgs, ... }:
    let
      generation-manager = pkgs.rustPlatform.buildRustPackage {
        pname = "generation-manager";
        version = "1.0.0";
        src = ./crate;
        useFetchCargoVendor = true;
        cargoHash = "sha256-AiRGXB6/LjM1WCMvHP5KeCnlruPaRWvwGPjATlf8sTA=";
      };
    in
    {
      home.packages = [ generation-manager ];
    };
}
