{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [pkgs.kooha];
  };
}
