{ config, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.store-link-helper = pkgs.rustPlatform.buildRustPackage {
        pname = "store-link-helper";
        version = "1.0.0";
        src = ./crate;
        useFetchCargoVendor = true;
        cargoHash = "";
      };
      devshells.store-link-helper.devshell = {
        packages = with pkgs; [
          cargo
          clippy
          gcc
          rust-analyzer
          rustc
        ];
        packagesFrom = [
          # > error: collision between `/nix/store/<hash>-cargo-1.84.1/bin/cargo' and `/nix/store/<hash>-auditable-cargo-1.84.1/bin/cargo'
          # psArgs.config.packages.store-link-helper
        ];
      };
    };
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ config.flake.packages.${pkgs.system}.store-link-helper ];
    };
}
