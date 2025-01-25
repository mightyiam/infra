{ self, ... }:
{
  boot.kernelModules = [ "kvm-amd" ];

  imports = [ self.inputs.ucodenix.nixosModules.default ];

  # https://github.com/e-tho/ucodenix/issues/32
  services.ucodenix = {
    enable = true;
    cpuModelId = "00A60F12";
  };
}
