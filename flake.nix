{
  nixConfig.extra-experimental-features = [ "pipe-operators" ];
  inputs = {
    # https://github.com/catppuccin/nix/pull/358
    catppuccin.url = "github:/ryand56/catppuccin-nix/home-manager-kvantum-fix"; # "github:catppuccin/nix"
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-on-droid.inputs.home-manager.follows = "home-manager";
    nix-on-droid.inputs.nixpkgs-docs.follows = "nixpkgs";
    nix-on-droid.inputs.nixpkgs-for-bootstrap.follows = "nixpkgs";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid.url = "github:nix-community/nix-on-droid";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixvim.inputs.devshell.follows = "devshell";
    nixvim.inputs.flake-parts.follows = "flake-parts";
    nixvim.inputs.home-manager.follows = "home-manager";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.treefmt-nix.follows = "treefmt-nix";
    nixvim.url = "github:nix-community/nixvim";
    sink-rotate.inputs.flake-parts.follows = "flake-parts";
    sink-rotate.inputs.nixpkgs.follows = "nixpkgs";
    sink-rotate.inputs.treefmt-nix.follows = "treefmt-nix";
    sink-rotate.url = "github:mightyiam/sink-rotate";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inputs = inputs; } {
      imports = [
        ./catppuccin.nix
        ./fmt.nix
        ./meta.nix
        ./nixvim
        ./nix-on-droid-configurations
        ./nixos-configurations.nix
        ./system-diff.nix
        inputs.devshell.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
