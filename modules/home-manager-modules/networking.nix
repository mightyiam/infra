{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gping
    bandwhich
    curl
    bind # for dig
  ];
}
