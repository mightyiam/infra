{ config, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.generation-manager = pkgs.rustPlatform.buildRustPackage {
        pname = "generation-manager";
        version = "1.0.0";
        src = ./crate;
        useFetchCargoVendor = true;
        cargoHash = "sha256-/LzxXS0SEyarigor0yXvb4rUbig1qS5p9BOef5/4blw=";
      };
      make-shells.generation-manager = {
        packages = with pkgs; [
          cargo
          clippy
          gcc
          rust-analyzer
          rustc
        ];
        inputsFrom = [
          # > error: collision between `/nix/store/<hash>-cargo-1.84.1/bin/cargo' and `/nix/store/<hash>-auditable-cargo-1.84.1/bin/cargo'
          # self'.packages.generation-manager
        ];
      };
    };
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ config.flake.packages.${pkgs.system}.generation-manager ];
    };
}
