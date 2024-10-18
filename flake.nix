{
  nixConfig.extra-experimental-features = [ "pipe-operators" ];
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    sink-rotate.url = "github:mightyiam/sink-rotate";
    sink-rotate.inputs.nixpkgs.follows = "nixpkgs";
    sink-rotate.inputs.flake-parts.follows = "flake-parts";
    sink-rotate.inputs.treefmt-nix.follows = "treefmt-nix";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid.url = "github:nix-community/nix-on-droid";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid.inputs.home-manager.follows = "home-manager";
    nix-on-droid.inputs.nixpkgs-docs.follows = "nixpkgs";
    nix-on-droid.inputs.nixpkgs-for-bootstrap.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inputs = inputs; } {
      imports = [
        inputs.devshell.flakeModule
        ./fmt.nix
        ./meta.nix
        ./nix-on-droid-configurations
        ./nixos-configurations.nix
        ./system-diff.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
