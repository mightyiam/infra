{ inputs, ... }:
{
  flake.modules.nixos.facter = {
    imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
    facter.detected.dhcp.enable = false;
  };
}
