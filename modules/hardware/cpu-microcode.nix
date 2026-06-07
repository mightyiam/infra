{inputs, ...}: {
  nixos.modules.base = nixosArgs: {
    imports = [inputs.ucodenix.nixosModules.default];
    services.ucodenix.cpuModelId = nixosArgs.config.hardware.facter.reportPath;
  };
}
