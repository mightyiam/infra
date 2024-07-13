{inputs, ...}: {
  flake.homeManagerModules.mightyiam.imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ./home.nix
  ];

  perSystem.checks.home =
    (inputs.evalExample ../examples/home/flake.nix)
    .homeManagerConfigurations
    .mightyiam
    .config
    .home
    .activationPackage;
}
