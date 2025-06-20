{ config, ... }:
{
  ipfi.inputs = {
    nixpkgs.upstream = {
      url = "https://github.com/NixOS/nixpkgs.git";
      ref = "nixpkgs-unstable";
    };
    home-manager.upstream = {
      url = "https://github.com/nix-community/home-manager.git";
      ref = "master";
    };
    stylix.upstream = {
      url = "https://github.com/nix-community/stylix.git";
      ref = "master";
    };
  };

  flake.modules.nixos.pc = config.ipfi.nixosModule;

  perSystem = psArgs: {
    make-shells.default.packages = [ psArgs.config.ipfi.commands ];
  };
}
