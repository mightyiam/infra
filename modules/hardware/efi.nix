{
  nixos.modules.efi = {pkgs, ...}: {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub.efiSupport = true;
    };

    environment.systemPackages = [
      pkgs.efivar
      pkgs.efibootmgr
    ];
  };
}
