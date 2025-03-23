{ config, ... }:
{
  perSystem =
    psArgs@{ pkgs, ... }:
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
          psArgs.config.packages.store-link-helper
        ];
      };
    };
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ config.flake.packages.${pkgs.system}.store-link-helper ];
    };
}
