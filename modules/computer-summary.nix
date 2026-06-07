{
  homeManager.modules.base = {pkgs, ...}: {
    home.packages = with pkgs; [fastfetch];
  };
}
