{lib, ...}: {
  options.nixos.modules.efi = lib.mkOption {
    type = lib.types.deferredModuleWith {
      staticModules = [
        (nixosArgs @ {pkgs, ...}: {
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
        })
      ];
    };
    default = {};
  };
}
