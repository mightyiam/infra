{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo-watch
    cargo-outdated
    #cargo-feature
  ];
}
