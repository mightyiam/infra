{ lib, ... }:
{
  flake.modules.nixos.pc = nixosArgs: {
    options.boot.loader.grub.skipMenuUnlessShift = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    config.boot.loader = {
      timeout = 2;

      grub.extraConfig = lib.mkIf nixosArgs.config.boot.loader.grub.skipMenuUnlessShift ''
        if keystatus; then
          if keystatus --shift; then
            set timeout=-1
          else
            set timeout=0
          fi
        fi
      '';
    };
  };
}
