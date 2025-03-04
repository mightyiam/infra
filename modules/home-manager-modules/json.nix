{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
  ];
}
