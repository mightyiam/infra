{ util, ... }:
{
  flake.modules.nixos = util.readModulesDir ./.;
}
