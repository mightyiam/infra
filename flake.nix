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
        inputs.treefmt-nix.flakeModule
        ./nixos-modules.nix
      ];

      flake = {
        homeManagerModules.mightyiam.imports = [
          inputs.catppuccin.homeManagerModules.catppuccin
          ./home/home.nix
        ];
      };

      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.mdformat.enable = true;
          programs.rustfmt.enable = true;
          programs.shfmt.enable = true;
          programs.stylua.enable = true;
          programs.yamlfmt.enable = true;
          settings.global.excludes = [
            "*/.gitignore"
            "*.toml"
          ];
        };

        checks = {
          home =
            (inputs.evalExample examples/home/flake.nix)
            .homeManagerConfigurations
            .mightyiam
            .config
            .home
            .activationPackage;

          "host/termitomyces" =
            (inputs.evalExample ./examples/hosts/termitomyces/flake.nix)
            .nixosConfigurations
            .termitomyces
            .config
            .system
            .build
            .toplevel;

          "host/ganoderma" =
            (inputs.evalExample ./examples/hosts/ganoderma/flake.nix)
            .nixosConfigurations
            .ganoderma
            .config
            .system
            .build
            .toplevel;
        };

        devshells.default = {
          commands = [
            {
              help = "flake check that doesn't write lock file";
              name = "check";
              command = "nix flake check --print-build-logs --no-write-lock-file";
            }
          ];
        };
      };
    });
}
