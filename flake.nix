{
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.catppuccin.url = "github:catppuccin/nix";
  outputs = {
    nixpkgs,
    self,
    catppuccin,
    home-manager,
    ...
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    evalExample = path: let
      flake = import path;
    in
      assert flake.inputs.nixconfigs.url == "github:mightyiam/nixconfigs";
        flake.outputs {nixconfigs = self;};
  in {
    nixosModules.mightyiam-desktop = {
      imports = [
        ./nixos-modules/hosts/mightyiam-desktop
        home-manager.nixosModules.home-manager
        ({lib, ...}: {
          options.self = lib.mkOption {
            type = lib.types.anything;
            default = self;
          };
        })
      ];
    };

    homeManagerModules.mightyiam = {
      imports = [
        catppuccin.homeManagerModules.catppuccin
        ./home/home.nix
      ];
    };

    checks.x86_64-linux.home =
      (evalExample examples/home/flake.nix)
      .homeManagerConfigurations
      .mightyiam
      .config
      .home
      .activationPackage;

    checks.x86_64-linux."host/mightyiam-desktop" =
      (evalExample ./examples/hosts/mightyiam-desktop/flake.nix)
      .nixosConfigurations
      .mightyiam-desktop
      .config
      .system
      .build
      .toplevel;

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        (pkgs.writeShellScriptBin "check" ''
          nix flake check --no-write-lock-file
        '')
      ];
    };
  };
}
