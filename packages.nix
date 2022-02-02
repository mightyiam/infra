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
    tor-browser-bundle-bin
    transmission-gtk
    vlc
    watchexec
    wl-clipboard
    xdg-utils
  ];
}
