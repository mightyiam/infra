with builtins; { pkgs, ... }:
let
  fontPackages = (import ./fonts.nix).packages pkgs;
  packages = with pkgs; [
    anki
    bandwhich
    du-dust
    imv
    neofetch
    pavucontrol
    procs
    ripgrep
    ripgrep-all
    swayidle
    swaylock
    tokei
    tor-browser-bundle-bin
    transmission-gtk
    vlc
    watchexec
    wl-clipboard
    xdg-utils
  ];
in
{
  home.packages = concatLists [
    fontPackages
    packages
  ];
}
