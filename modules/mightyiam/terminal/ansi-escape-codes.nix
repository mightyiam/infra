{
  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [ansifilter];
  };
}
