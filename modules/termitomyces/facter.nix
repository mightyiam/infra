{
  configurations.nixos.termitomyces.modules = [
    {
      facter.reportPath = ./facter.json;
    }
  ];
}
