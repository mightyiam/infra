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
    (import ./programs.nix)
    (import ./sway.nix)
  ];

  programs = {
    home-manager = {
      enable = true;
      path = builtins.toString homeDirectory + "/src/home-manager";
    };
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

