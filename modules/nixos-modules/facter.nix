{ self, ... }:
{
  imports = [
    self.inputs.nixos-facter-modules.nixosModules.facter
  ];
}
