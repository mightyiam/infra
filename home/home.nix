with builtins; { config, pkgs, options, lib, ... }:
let
  username = "mightyiam";
  config = import ./config.nix;
  getName = lib.getName;
  packages = (import ./packages.nix) pkgs;
  modules = import ./modules;
in
{
  imports = concatMap (feature: getAttr feature modules) config.features;
  home.packages = concatMap (feature: getAttr feature packages) config.features;

  programs.home-manager = {
    enable = true;
    path = if config ? homeManagerPath then config.homeManagerPath else null;
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "21.05";
    sessionVariables.TZ = "\$(<~/.config/timezone)";
  };
}

