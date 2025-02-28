{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ansifilter
  ];
}
