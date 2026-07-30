{
  lib,
  mkModuleOption,
  ...
}: {
  options.nixos.modules.efi = mkModuleOption {
    key = "efi";
    static = nixosArgs @ {pkgs, ...}: {
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

    default = {};
  };
}
