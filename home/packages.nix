with builtins;
  pkgs: let
    fontPackages = (import ./fonts.nix).packages pkgs;
  in
    with pkgs; {
      tui = [
        bandwhich
        du-dust
        neofetch
        procs
        ripgrep
        ripgrep-all
        tokei
        watchexec

        # nix
        alejandra
        rnix-lsp
        nurl

        # rust
        rustup
        rust-analyzer
        cargo-watch
        cargo-outdated
        cargo-feature

        mob
      ];
      gui = concatLists [
        fontPackages
        [
          anki
          imv
          pavucontrol
          tor-browser-bundle-bin
          transmission-gtk
          vlc
          wl-clipboard
          xdg-utils
        ]
      ];
    }
