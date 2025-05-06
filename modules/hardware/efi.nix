{
  flake.modules = {
    nixos.efi.boot.loader = {
      efi.canTouchEfiVariables = true;
      grub.efiSupport = true;
    };

    home-manager.base =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.efivar
          pkgs.efibootmgr
        ];
      };
  };
}
