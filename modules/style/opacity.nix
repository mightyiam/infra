let
  polyModule = {
    stylix.opacity = {
      applications = 0.9;
      desktop = 0.9;
      popups = 0.9;
      terminal = 0.9;
    };
  };
in
{
  flake.modules = {
    nixos.pc = polyModule;
    homeManager.gui = polyModule;
    nixOnDroid.base = polyModule;
  };
}
