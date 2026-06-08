{inputs, ...}: {
  flake-file.inputs.ucodenix = {
    url = "github:e-tho/ucodenix";
    flake = false;
  };

  nixos.modules.base = nixosArgs: {
    imports = ["${inputs.ucodenix}/modules/nixos.nix"];
    services.ucodenix.cpuModelId = nixosArgs.config.hardware.facter.reportPath;
  };
}
