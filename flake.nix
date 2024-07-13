{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: let
    localInputs = {
      evalExample = path: let
        flake = import path;
      in
        assert flake.inputs.nixconfigs.url == "github:mightyiam/nixconfigs";
          flake.outputs {nixconfigs = inputs.self;};
    };
  in
    inputs.flake-parts.lib.mkFlake {inputs = inputs // localInputs;} ({inputs, ...}: {
      imports = [
        inputs.devshell.flakeModule
        ./nixos-modules.nix
        ./home
        ./fmt.nix
        ./devshell.nix
      ];

      systems = [
        "x86_64-linux"
      ];
    });
}
