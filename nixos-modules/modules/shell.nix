{ pkgs, ... }:
let
  inherit (pkgs) zsh;
in
{
  programs.zsh.enable = true;
  users.defaultUserShell = zsh;
}
