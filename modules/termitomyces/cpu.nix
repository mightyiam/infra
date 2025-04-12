{
  flake.modules.nixos."nixosConfigurations/termitomyces" = {
    services.ucodenix = {
      enable = true;
      cpuModelId = "00A60F12";
    };
  };
}
