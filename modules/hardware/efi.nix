{lib, ...}: {
  options.nixos.modules.efi = lib.mkOption {
    type = lib.types.deferredModule;
    readOnly = true;
    default = nixosArgs @ {pkgs, ...}: {
      key = "efi";
      boot.loader = {
        efi = {
          efiSysMountPoint = nixosArgs.config.boot.partlabels |> lib.head |> lib.getAttr "path";
          canTouchEfiVariables = true;
        };
        grub.efiSupport = true;
      };

      environment.systemPackages = [
        pkgs.efivar
        pkgs.efibootmgr
      ];
    };
  };
}
