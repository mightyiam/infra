{
  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [anki];
  };
}
