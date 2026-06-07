{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = with pkgs; [vlc];
  };
}
