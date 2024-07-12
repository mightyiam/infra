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
  };
  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
      ];

      flake = {
        nixosModules.termitomyces.imports = [
          ./nixos-modules/hosts/termitomyces
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.mightyiam.imports = [
              self.homeManagerModules.mightyiam
            ];
          }
        ];

        nixosModules.ganoderma.imports = [
          ./nixos-modules/hosts/ganoderma
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.mightyiam.imports = [
              self.homeManagerModules.mightyiam
            ];
          }
        ];

        homeManagerModules.mightyiam.imports = [
          inputs.catppuccin.homeManagerModules.catppuccin
          ./home/home.nix
        ];
      };

      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        checks = let
          evalExample = path: let
            flake = import path;
          in
            assert flake.inputs.nixconfigs.url == "github:mightyiam/nixconfigs";
              flake.outputs {nixconfigs = self;};
        in {
          home =
            (evalExample examples/home/flake.nix)
            .homeManagerConfigurations
            .mightyiam
            .config
            .home
            .activationPackage;

          "host/termitomyces" =
            (evalExample ./examples/hosts/termitomyces/flake.nix)
            .nixosConfigurations
            .termitomyces
            .config
            .system
            .build
            .toplevel;

          "host/ganoderma" =
            (evalExample ./examples/hosts/ganoderma/flake.nix)
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
              command = "nix flake check --no-write-lock-file";
            }
          ];
        };
      };
    };
}
