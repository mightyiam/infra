{ lib, inputs, ... }:
{
  flake.modules.nixos.pc = nixosArgs: {
    imports = [ inputs.ucodenix.nixosModules.default ];
    boot.kernelParams = lib.optional nixosArgs.config.services.ucodenix.enable "microcode.amd_sha_check=off";
  };
}
