{ pkgs, ... }: {
  home.packages = with pkgs; [
    anki
    bandwhich
    direnv
    du-dust
    imv
    libnotify
    neofetch
    pavucontrol
    procs
    ripgrep
    ripgrep-all
    rnix-lsp
    swayidle
    swaylock
    tokei
    transmission-gtk
    vlc
    wl-clipboard
    xdg-utils
  ];
}
