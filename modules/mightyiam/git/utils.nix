{
  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [
      git-trim
      serie
    ];
  };
}
