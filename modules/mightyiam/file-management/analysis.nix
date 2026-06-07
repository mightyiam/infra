{
  home.base = {pkgs, ...}: {
    home.packages = [
      pkgs.file
      pkgs.tokei
      pkgs.dust
    ];
  };
}
