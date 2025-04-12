{
  flake.modules.nixos."nixosConfigurations/termitomyces" = {
    # https://github.com/e-tho/ucodenix/issues/32
    services.ucodenix = {
      enable = true;
      cpuModelId = "00A60F12";
    };
  };
}
