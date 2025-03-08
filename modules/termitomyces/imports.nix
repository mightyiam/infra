{
  config,
  ...
}:
{
  flake.modules.nixos."nixosConfigurations/termitomyces".imports = with config.flake.modules.nixos; [
    workstation
  ];
}
