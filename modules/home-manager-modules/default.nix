{ util, ... }:
{
  flake.modules.homeManager = util.readModulesDir ./.;
}
