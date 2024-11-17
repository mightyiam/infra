{ self, ... }:
{
  boot.kernelModules = [ "kvm-amd" ];

  imports = [ self.inputs.ucodenix.nixosModules.default ];

  services.ucodenix = {
    enable = true;
    cpuModelId = "00A60F12";
  };
}
