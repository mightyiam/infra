{ pkgs, ... }:
{
  home.packages = with pkgs; [
    glab
  ];
}
