{
  home.base = {pkgs, ...}: {
    home.packages = [pkgs.openssl];
  };
}
