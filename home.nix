{ config, pkgs, lib, options, ... }:

let
  secrets = import ./secrets.nix;
  homeDirectory = /home/mightyiam;
  configDir = ".config";
  configHome = builtins.toString homeDirectory + "/${configDir}";
  sway-outputs = { left = "DP-2"; right = "DP-1"; };
  bar = let id = "bottom"; in {
    inherit id;
    swaybar = (import ./fonts).applyToSwaybar {
      statusCommand = "i3status-rs ${configHome}/i3status-rust/config-${id}.toml";
      trayOutput = sway-outputs.left;
    };
    i3status-rust = import ./i3status-rust.nix id;
  };
in {
  imports = [
    (import ./unfree)
    (import ./packages)
    (import ./xdg)
    (import ./accounts)
    (import ./systemd)
    (import ./fonts).module
    (import ./programs)
  ];

  programs = {
    i3status-rust = { enable = true; bars = {} // bar.i3status-rust; };
    chromium = {
      enable = true;
      extensions = [
        { id = "hdokiejnpimakedhajhdlcegeplioahd"; }
      ];
    };
    home-manager = {
      enable = true;
      path = builtins.toString homeDirectory + "/src/home-manager";
    };
    mako = import ./mako.nix sway-outputs.left;
  };

  services = {
    lorri.enable = true;
  };

  wayland.windowManager.sway = import ./sway/main.nix {
    inherit lib;
    inherit sway-outputs;
    I3RS_GITHUB_TOKEN = secrets.I3RS_GITHUB_TOKEN;
    inherit bar;
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

