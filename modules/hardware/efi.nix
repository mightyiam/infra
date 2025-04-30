{
  flake.modules.nixos.efi.boot.loader = {
    efi.canTouchEfiVariables = true;
    grub.efiSupport = true;
  };
}
