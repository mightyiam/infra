{
  config,
  ...
}:
{
  flake.modules.homeManager.gui.imports = [ config.flake.modules.homeManager.base ];
}
