{
  boot.initrd.kernelModules = ["amdgpu"];
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
}
