{
  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [tor-browser];
  };
}
