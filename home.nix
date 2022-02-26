with builtins; { config, pkgs, options, ... }:

let
  homeDirectory = toString /home/mightyiam;
in {
  imports = [
    (import ./unfree.nix)
    (import ./packages.nix)
    (import ./merely-enabled.nix)
    (import ./xdg.nix)
    (import ./fontconfig.nix)
    (import ./accounts.nix)
    (import ./systemd.nix)
    (import ./zsh)
    (import ./tmux.nix)
    (import ./alacritty.nix)
    (import ./atuin.nix)
    (import ./firefox.nix)
    (import ./chromium.nix)
    (import ./neovim)
    (import ./vscode.nix)
    (import ./gh.nix)
    (import ./ssh.nix)
    (import ./starship)
    (import ./git.nix)
    (import ./bottom.nix)
    (import ./wlsunset.nix)
    (import ./sway.nix)
    (import ./sway-bar.nix)
    (import ./udiskie.nix)
  ];

  programs.home-manager = {
    enable = true;
    path = toString homeDirectory + "/src/home-manager";
  };

  home = {
    username = "mightyiam";
    inherit homeDirectory;
    stateVersion = "21.05";
  };
}

