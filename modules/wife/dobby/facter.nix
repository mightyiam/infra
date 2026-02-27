{
  configurations.nixos.dobby.module = {
    hardware.facter.reportPath = ./facter.json;
  };
}
