{
  configurations.nixos.termitomyces.module = {
    services.ucodenix = {
      enable = true;
      cpuModelId = "00A60F12";
    };
  };
}
