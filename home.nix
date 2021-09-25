{ config, pkgs, options, ... }:

let
  homeDirectory = toString /home/mightyiam;
in {
  imports = [
    (import ./unfree)
    (import ./packages)
    ((import ./xdg) homeDirectory)
    (import ./accounts)
    (import ./systemd)
    (import ./fonts).module
    (import ./programs)
    (import ./sway)
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

