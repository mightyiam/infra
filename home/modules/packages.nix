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
    file
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

  gui = concatLists [
    config.gui.fonts.packages
    (with pkgs; [
      anki
      gh-markdown-preview
      gimp
      imv
      inkscape
      pavucontrol
      qpwgraph
      tor-browser-bundle-bin
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
