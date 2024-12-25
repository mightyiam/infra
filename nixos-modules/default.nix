{ util, ... }:
{
  flake.nixosModules = util.readModulesDir ./.;
}
