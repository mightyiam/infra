{
  nixos.modules.base = {pkgs, ...}: {
    hardware.facter.detected.dhcp.enable = false;
    environment.systemPackages = [pkgs.nixos-facter];
  };
}
