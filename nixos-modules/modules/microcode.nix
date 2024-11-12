{ self, ... }:
{
  imports = [ self.inputs.ucodenix.nixosModules.default ];

  services.ucodenix.enable = true;
}
