{
  config,
  pkgs,
  lib,
  ...
}:
let
  tui = with pkgs; [
    ansifilter
    atool
    bandwhich
    curl
    bind # for dig
    du-dust
    fd
    file
    gh-dash
    git-instafix
    git-trim
    glab
    gping
    gptfdisk
    jq
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
    nix-fast-build
    nix-tree
    nixd
    nurl
    nvd
    statix
    nix-diff
    #nix-melt
    nix-prefetch-scripts

    # lua
    lua-language-server

    # rust
    cargo-watch
    cargo-outdated
    #cargo-feature

    # yaml
    yaml-language-server

    mob
  ];

  gui = lib.concatLists [
    config.gui.fonts.packages
    (with pkgs; [
      anki
      gh-markdown-preview
      gimp
      gucharmap
      imv
      inkscape
      pavucontrol
      qpwgraph
      signal-desktop
      tor-browser-bundle-bin
      vlc
      wl-clipboard
      wl-color-picker
      xdg-utils
    ])
  ];
in
{
  home.packages = lib.concatLists [
    tui
    (lib.optionals config.gui.enable gui)
  ];
}
