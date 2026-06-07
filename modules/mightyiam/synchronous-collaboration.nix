{
  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [
      mob
    ];
  };
}
