{
  configurations.nixos.termitomyces.modules = [
    {
      services.ucodenix = {
        enable = true;
        cpuModelId = "00A60F12";
      };
    }
  ];
}
