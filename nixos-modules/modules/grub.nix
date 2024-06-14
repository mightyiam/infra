{
  boot.loader.timeout = 4;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.mirroredBoots = [
    {
      devices = ["nodev"];
      path = "/boot0";
    }
    {
      devices = ["nodev"];
      path = "/boot1";
    }
  ];
  boot.loader.efi.canTouchEfiVariables = true;
}
