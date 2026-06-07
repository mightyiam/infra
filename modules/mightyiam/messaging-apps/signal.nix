{
  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [signal-desktop];
  };
}
