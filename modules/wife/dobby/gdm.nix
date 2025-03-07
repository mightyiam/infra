{
  flake.modules.nixos."nixosConfigurations/dobby".services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
}
