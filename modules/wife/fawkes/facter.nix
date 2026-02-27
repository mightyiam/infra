{
  configurations.nixos.fawkes.module = {
    hardware.facter.reportPath = ./facter.json;
  };
}
