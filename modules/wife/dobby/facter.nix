{
  configurations.nixos.dobby.modules = [
    {
      facter.reportPath = ./facter.json;
    }
  ];
}
