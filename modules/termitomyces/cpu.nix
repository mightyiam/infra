{ inputs, ... }:
{
  flake.modules.nixos."nixosConfigurations/termitomyces" = {
    imports = [ inputs.ucodenix.nixosModules.default ];

    boot.kernelParams = [ "microcode.amd_sha_check=off" ];

    # https://github.com/e-tho/ucodenix/issues/32
    services.ucodenix = {
      enable = true;
      cpuModelId = "00A60F12";
    };
  };
}
