{
  configurations.nixos.astraeus.module = {
    hardware.facter.reportPath = ./facter.json;
  };
}
