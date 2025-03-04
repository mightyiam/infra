{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mob
  ];
}
