{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    concatLists
    optionals
    ;

  tui = with pkgs; [
    ansifilter
    atool
    bandwhich
    du-dust
    fd
    gh-dash
    git-instafix
    lsof
    neofetch
    pciutils
    procs
    psmisc
    ripgrep
    ripgrep-all
    tokei
    unzip
    usbutils
    watchexec

    # javascript
    vscode-langservers-extracted

    # nix
    alejandra
    nixd
    nurl
    comma
    statix
    nix-diff

    # lua
    lua-language-server

    # rust
    cargo-watch
    cargo-outdated
    cargo-feature

    # yaml
    yaml-language-server

    mob
  ];

  fontPackages = (import ../fonts.nix).packages pkgs;

  gui = concatLists [
    fontPackages
    (with pkgs; [
      anki
      gh-markdown-preview
      gimp
      imv
      inkscape
      pavucontrol
      qpwgraph
      tor-browser-bundle-bin
      transmission-gtk
      vlc
      wl-clipboard
      wl-color-picker
      xdg-utils
    ])
  ];
in {
  home.packages = concatLists [
    tui
    (optionals config.gui.enable gui)
  ];
}
