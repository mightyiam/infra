{
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
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inputs = inputs;} {
      imports = [
        ./nixos-configurations.nix
        ./fmt.nix
      ];

      systems = [
        "x86_64-linux"
      ];
    };
}
