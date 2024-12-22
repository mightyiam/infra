{ self, ... }:
{
  flake.nixosModules = self.lib.readModulesDir ./.;
}
