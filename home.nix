{ config, pkgs, options, ... }:

let
  homeDirectory = toString /home/mightyiam;
in {
  imports = [
    (import ./unfree.nix)
    (import ./packages.nix)
    ((import ./xdg.nix) homeDirectory)
    (import ./accounts.nix)
    (import ./systemd.nix)
    (import ./fonts.nix).module
    (import ./zsh)
    (import ./tmux.nix)
    (import ./alacritty.nix)
    (import ./exa.nix)
    (import ./firefox.nix)
    (import ./chromium.nix)
    (import ./command-not-found.nix)
    (import ./info.nix)
    (import ./bat.nix)
    (import ./neovim.nix)
    (import ./vscode.nix)
    (import ./gh.nix)
    (import ./ssh.nix)
    (import ./starship)
    (import ./git.nix)
    (import ./bottom.nix)
    (import ./sway.nix)
  ];

  programs.home-manager = {
    enable = true;
    path = builtins.toString homeDirectory + "/src/home-manager";
  };

  services = {
    lorri.enable = true;
  };

  programs.firefox.package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    forceWayland = true;
  };
  home = {
    username = "mightyiam";
    inherit homeDirectory;
    stateVersion = "21.05";
  };
}

