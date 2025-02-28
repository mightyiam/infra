{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gptfdisk
  ];
}
